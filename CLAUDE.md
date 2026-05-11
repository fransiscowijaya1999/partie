# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Partie is a Flutter app (desktop + mobile) for building a personal vehicle parts catalogue. Storage is local-only: SQLite via Drift, plus loose image files on the filesystem. No backend, no auth, no network calls.

## Common commands

```sh
flutter pub get                                                              # install deps
flutter run                                                                   # run on the default device
flutter analyze                                                               # lint
flutter test                                                                  # all tests
flutter test test/drift/partie_database/migration_test.dart                   # migration tests only
flutter build windows                                                         # also: macos | linux | apk | ios | web
```

### Code generation (Drift)

Drift generates `database.g.dart`, `database.steps.dart`, and the per-version schema JSONs under `lib/tables/partie_database/`. Re-run after any change to a table class or to `database.dart`:

```sh
dart run build_runner build --delete-conflicting-outputs                                                # regen database.g.dart + database.steps.dart
dart run drift_dev schema dump lib/database.dart lib/tables/partie_database                             # dump the new schema (do this right after bumping schemaVersion)
dart run drift_dev schema generate lib/tables/partie_database test/drift/partie_database/generated      # refresh the migration test helpers
```

`build.yaml` points `drift_dev` at `lib/database.dart` and uses `lib/tables` as the schema dir, so these paths are not arbitrary.

## Architecture

### Layering

`screens/` and `components/` → `repositories/` → `database.dart` (Drift singleton) → `tables/`.

- **`lib/database.dart`** — defines `AppDatabase` and exports a process-wide singleton `db`. Every other layer imports `package:partie/database.dart` and accesses tables via `db.managers.<table>` or `db.customSelect(...)` / raw `db.select(...)`. There is no DI, no repository interface. Repository classes are stateless and expose only `static` methods.
- **`repositories/`** — all SQL + business rules. Multi-step writes wrap in `db.transaction(...)`. Cross-resource cleanup (deleting catalog image files when a part is deleted, deleting orphaned parts when their last vehicle link is removed) is implemented in repository code, not via FK cascade alone.
- **`screens/` + `components/`** — both layers import generated entities (`Vehicle`, `Part`, etc.) directly from `database.dart`. UI alternates between two patterns depending on the screen:
  - **`StreamBuilder` over a `*Watch` repository method** — used for list screens (`VehiclesScreen`, `ItemsScreen`) where Drift's reactive subscriptions auto-refresh on writes. The repository often bundles `(items stream, count stream)` in a small holder class (`VehicleListStream`, `ItemListStream`) for paginated lists.
  - **`FutureBuilder` + `setState`** — used for detail screens (`VehicleDetailScreen`, `PartDetailScreen`'s children list). After any mutation, the screen re-creates the `Future` in `setState` to force a refetch. `PartDetailScreen` is a hybrid: a `Stream` for the part header, a `Future` for the children list.
- **`states/vehicle.dart`** — a `ChangeNotifier` stub. The setters are `set x(value) { x = value; notifyListeners(); }`, which recurse infinitely. Nothing imports it. Treat the `states/` directory as **abandoned / not wired up** — don't add to it; widgets manage their own state.
- **`models/`** — view-model classes (e.g. `PartChild`) that flatten a join into a single struct the UI can render in one list. Distinct from Drift's generated row classes.

### Data model

Six tables in `lib/tables/`, all listed in the `@DriftDatabase` annotation in `lib/database.dart`:

- **`vehicles`** — self-referential tree (`parentId`). A child vehicle **inherits parts** from its parent: `VehicleRepository.searchPart(vehicleId, parentId: ...)` unions parts linked to `vehicleId` with parts linked to `parentId`.
- **`parts`** — self-referential tree (parts can contain sub-parts as a category). Optional `catalogImagePath` — a path to a file on disk, **not a blob**.
- **`items`** — leaf catalog entries. Image is a `BlobColumn` (`Uint8List`) inline in the row (added in v7).
- **`part_items`** — links a part to an item with `qty`, `description`, and optional `(topCoordinate, leftCoordinate)` for placing a clickable dot on the part's catalog image in `CatalogView`.
- **`part_vehicles`** — many-to-many between parts and vehicles. **A part with zero remaining vehicle links is deleted entirely** (see `PartRepository.unlinkPart`); a part orphaned from all vehicles cannot exist on its own.
- **`inherited_part_replacements`** — override layer for parts inherited from a parent vehicle. Two modes, encoded by whether `inheritedPartId` is null:
  - non-null `inheritedPartId` → "for this child vehicle, replace the inherited part with `replacementPartId`" (the inherited one is hidden from search results)
  - null `inheritedPartId` → a free-standing replacement entry (not currently used to hide anything, since the WHERE clause keys off `inheritedPartId`)

### Inheritance / replacement query (raw SQL)

`VehicleRepository.searchPartWatch` / `searchPart` use a hand-written `db.customSelect` because the Drift manager DSL couldn't express the conditional union + sub-select cleanly (a commented-out manager-API attempt is preserved above the SQL). The logic:

```
parts directly linked to the vehicle
UNION
parts linked to its parent vehicle (the "inherited" set)
  MINUS parts whose id appears as inheritedPartId in
        inherited_part_replacements rows for this vehicle (the "overridden" set)
```

The `LEFT JOIN inherited_part_replacements ON replacement_part_id = parts.id` in that SQL is vestigial — no column from that join is read or filtered on; the actual exclusion happens via a sub-SELECT against `inheritedPartId`.

### Cascade semantics: explicit vs. FK

Several tables have `onDelete: KeyAction.cascade` declared in `tables/`, but the repository code often does the cascade itself anyway:

- **`VehicleRepository.deleteVehicle`** loops over `partVehicles` for the vehicle and calls `PartRepository.unlinkPart` for each *before* deleting the vehicle. The FK cascade alone would silently delete the join rows but leave parts behind that have no remaining vehicle links (orphans).
- **`PartRepository.deletePart` / `unlinkPart` / `deletePartRelated`** walk the part tree manually so they can delete the on-disk catalog image file for each part as they go. Pure FK cascade would leave image files behind.

Rule of thumb when adding code that deletes anything: **think about whether a referenced file on disk needs to be deleted too**, and do it from the repository.

### Files vs. blobs (and the directory gotcha)

- **Part catalog image** → file on disk, absolute path stored in `parts.catalogImagePath`.
- **Item image** → `Uint8List` blob inside `items.image`. No separate file.

When a part's catalog image is **replaced or the part is deleted**, the repository must delete the old file (`PartRepository.updatePart` and friends already do). When a catalog image is **swapped**, also null out `topCoordinate`/`leftCoordinate` on every `partItem` for that part — the dot positions are in the *previous* image's pixel space and `CatalogView` scales them with `constraints.maxWidth / intrinsicWidth`, so they will land wrong on a new image.

**Directory inconsistency (real and load-bearing):**

- New catalog images are written by the UI to `getApplicationDocumentsDirectory()` (see `VehicleDetailScreen._showCreatePartDialog`, `PartDetailScreen._showEditPartDialog`).
- `BackupArchive.restoreFromZip` writes restored images into `getApplicationSupportDirectory()` and rewrites every `catalogImagePath` in the staging DB to point there.

That means after a restore, existing images live in Support but newly-created ones still go to Documents. Both paths are absolute in the DB so it works, but cross-machine and cross-restore behavior is asymmetric. If you touch image saving or backup, be aware that the source of truth for "where catalog images live" is the absolute path stored in each row, not a single directory.

### Migrations

`AppDatabase.schemaVersion` (currently `7`) is authoritative. The `migration` block in `lib/database.dart` is a stair of `if (from < N)` steps — **append a new step, never edit an existing one**, since users in the field have run them.

Two flavors of step exist:
- **Generated helper** (steps 2, 3, 4, 7): use `SchemaN(database: ...)` + `Migrator` for `createTable` / `addColumn` / `alterTable`.
- **Hand-written table rebuild** (steps 5, 6): `customStatement` to create a `*_new` table, `INSERT ... SELECT` to copy, drop the old, rename `*_new`. Used when the change is something `ALTER TABLE` can't do in SQLite — both 5 and 6 restructured `part_items`'s primary key (composite `(part_id, item_id)` → composite no `id` → adding an autoincrement `id`).

Workflow when changing a table:

1. Edit the table class in `lib/tables/`.
2. Bump `schemaVersion` and append an `if (from < N)` block to `migration`.
3. `drift_dev schema dump` (writes `lib/tables/partie_database/drift_schema_v{N}.json`).
4. `drift_dev schema generate` (refreshes `test/drift/partie_database/generated/`).
5. `build_runner build --delete-conflicting-outputs` (refreshes `database.g.dart` + `database.steps.dart`).
6. `flutter test test/drift/partie_database/migration_test.dart` — it iterates **every `from → to` pair**, so a wrong step in the middle breaks lots of cases.

### Backups

`lib/utils/backup_archive.dart` packages the live SQLite file + every distinct part catalog image into a zip with a `manifest.json` (recording `schemaVersion` and `createdAt`). Before reading the DB file it runs `PRAGMA wal_checkpoint(TRUNCATE)` so the WAL is folded back into the main file.

- **Restore refuses archives newer than the running app** (`manifest.schemaVersion > db.schemaVersion`). Older is fine — they will be migrated forward on next open.
- Restore opens the unzipped DB as a **staging `AppDatabase` instance** (separate from the live `db`), rewrites every `catalogImagePath` row to the new Support-directory location, closes staging, closes the live `db`, deletes the live `.sqlite` + `-wal` + `-shm`, and renames staging into place.
- After a successful restore, `BackupRestoreScreen` calls `SystemNavigator.pop()` to force the app to exit. The user must reopen — there is no in-process re-attach to the new DB.
