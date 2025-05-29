// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $VehiclesTable extends Vehicles with TableInfo<$VehiclesTable, Vehicle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehiclesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parentIdMeta = const VerificationMeta(
    'parentId',
  );
  @override
  late final GeneratedColumn<int> parentId = GeneratedColumn<int>(
    'parent_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, description, parentId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehicles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Vehicle> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(
        _parentIdMeta,
        parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Vehicle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Vehicle(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      description:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}description'],
          )!,
      parentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}parent_id'],
      ),
    );
  }

  @override
  $VehiclesTable createAlias(String alias) {
    return $VehiclesTable(attachedDatabase, alias);
  }
}

class Vehicle extends DataClass implements Insertable<Vehicle> {
  final int id;
  final String name;
  final String description;
  final int? parentId;
  const Vehicle({
    required this.id,
    required this.name,
    required this.description,
    this.parentId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<int>(parentId);
    }
    return map;
  }

  VehiclesCompanion toCompanion(bool nullToAbsent) {
    return VehiclesCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      parentId:
          parentId == null && nullToAbsent
              ? const Value.absent()
              : Value(parentId),
    );
  }

  factory Vehicle.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Vehicle(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      parentId: serializer.fromJson<int?>(json['parentId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'parentId': serializer.toJson<int?>(parentId),
    };
  }

  Vehicle copyWith({
    int? id,
    String? name,
    String? description,
    Value<int?> parentId = const Value.absent(),
  }) => Vehicle(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    parentId: parentId.present ? parentId.value : this.parentId,
  );
  Vehicle copyWithCompanion(VehiclesCompanion data) {
    return Vehicle(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Vehicle(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('parentId: $parentId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, parentId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Vehicle &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.parentId == this.parentId);
}

class VehiclesCompanion extends UpdateCompanion<Vehicle> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<int?> parentId;
  const VehiclesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.parentId = const Value.absent(),
  });
  VehiclesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String description,
    this.parentId = const Value.absent(),
  }) : name = Value(name),
       description = Value(description);
  static Insertable<Vehicle> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? parentId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (parentId != null) 'parent_id': parentId,
    });
  }

  VehiclesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? description,
    Value<int?>? parentId,
  }) {
    return VehiclesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      parentId: parentId ?? this.parentId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<int>(parentId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehiclesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('parentId: $parentId')
          ..write(')'))
        .toString();
  }
}

class $ItemsTable extends Items with TableInfo<$ItemsTable, Item> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'items';
  @override
  VerificationContext validateIntegrity(
    Insertable<Item> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Item map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Item(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      description:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}description'],
          )!,
    );
  }

  @override
  $ItemsTable createAlias(String alias) {
    return $ItemsTable(attachedDatabase, alias);
  }
}

class Item extends DataClass implements Insertable<Item> {
  final int id;
  final String name;
  final String description;
  const Item({required this.id, required this.name, required this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    return map;
  }

  ItemsCompanion toCompanion(bool nullToAbsent) {
    return ItemsCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
    );
  }

  factory Item.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Item(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
    };
  }

  Item copyWith({int? id, String? name, String? description}) => Item(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
  );
  Item copyWithCompanion(ItemsCompanion data) {
    return Item(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Item(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Item &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description);
}

class ItemsCompanion extends UpdateCompanion<Item> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  const ItemsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
  });
  ItemsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String description,
  }) : name = Value(name),
       description = Value(description);
  static Insertable<Item> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
    });
  }

  ItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? description,
  }) {
    return ItemsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $PartsTable extends Parts with TableInfo<$PartsTable, Part> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PartsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parentIdMeta = const VerificationMeta(
    'parentId',
  );
  @override
  late final GeneratedColumn<int> parentId = GeneratedColumn<int>(
    'parent_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES parts (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, description, parentId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'parts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Part> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(
        _parentIdMeta,
        parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Part map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Part(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      description:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}description'],
          )!,
      parentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}parent_id'],
      ),
    );
  }

  @override
  $PartsTable createAlias(String alias) {
    return $PartsTable(attachedDatabase, alias);
  }
}

class Part extends DataClass implements Insertable<Part> {
  final int id;
  final String name;
  final String description;
  final int? parentId;
  const Part({
    required this.id,
    required this.name,
    required this.description,
    this.parentId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<int>(parentId);
    }
    return map;
  }

  PartsCompanion toCompanion(bool nullToAbsent) {
    return PartsCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      parentId:
          parentId == null && nullToAbsent
              ? const Value.absent()
              : Value(parentId),
    );
  }

  factory Part.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Part(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      parentId: serializer.fromJson<int?>(json['parentId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'parentId': serializer.toJson<int?>(parentId),
    };
  }

  Part copyWith({
    int? id,
    String? name,
    String? description,
    Value<int?> parentId = const Value.absent(),
  }) => Part(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    parentId: parentId.present ? parentId.value : this.parentId,
  );
  Part copyWithCompanion(PartsCompanion data) {
    return Part(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Part(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('parentId: $parentId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, parentId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Part &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.parentId == this.parentId);
}

class PartsCompanion extends UpdateCompanion<Part> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<int?> parentId;
  const PartsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.parentId = const Value.absent(),
  });
  PartsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String description,
    this.parentId = const Value.absent(),
  }) : name = Value(name),
       description = Value(description);
  static Insertable<Part> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? parentId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (parentId != null) 'parent_id': parentId,
    });
  }

  PartsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? description,
    Value<int?>? parentId,
  }) {
    return PartsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      parentId: parentId ?? this.parentId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<int>(parentId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PartsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('parentId: $parentId')
          ..write(')'))
        .toString();
  }
}

class $PartItemsTable extends PartItems
    with TableInfo<$PartItemsTable, PartItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PartItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _partIdMeta = const VerificationMeta('partId');
  @override
  late final GeneratedColumn<int> partId = GeneratedColumn<int>(
    'part_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES parts (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<int> itemId = GeneratedColumn<int>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES items (id)',
    ),
  );
  static const VerificationMeta _qtyMeta = const VerificationMeta('qty');
  @override
  late final GeneratedColumn<String> qty = GeneratedColumn<String>(
    'qty',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [partId, itemId, qty, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'part_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<PartItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('part_id')) {
      context.handle(
        _partIdMeta,
        partId.isAcceptableOrUnknown(data['part_id']!, _partIdMeta),
      );
    } else if (isInserting) {
      context.missing(_partIdMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('qty')) {
      context.handle(
        _qtyMeta,
        qty.isAcceptableOrUnknown(data['qty']!, _qtyMeta),
      );
    } else if (isInserting) {
      context.missing(_qtyMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  PartItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PartItem(
      partId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}part_id'],
          )!,
      itemId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}item_id'],
          )!,
      qty:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}qty'],
          )!,
      description:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}description'],
          )!,
    );
  }

  @override
  $PartItemsTable createAlias(String alias) {
    return $PartItemsTable(attachedDatabase, alias);
  }
}

class PartItem extends DataClass implements Insertable<PartItem> {
  final int partId;
  final int itemId;
  final String qty;
  final String description;
  const PartItem({
    required this.partId,
    required this.itemId,
    required this.qty,
    required this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['part_id'] = Variable<int>(partId);
    map['item_id'] = Variable<int>(itemId);
    map['qty'] = Variable<String>(qty);
    map['description'] = Variable<String>(description);
    return map;
  }

  PartItemsCompanion toCompanion(bool nullToAbsent) {
    return PartItemsCompanion(
      partId: Value(partId),
      itemId: Value(itemId),
      qty: Value(qty),
      description: Value(description),
    );
  }

  factory PartItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PartItem(
      partId: serializer.fromJson<int>(json['partId']),
      itemId: serializer.fromJson<int>(json['itemId']),
      qty: serializer.fromJson<String>(json['qty']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'partId': serializer.toJson<int>(partId),
      'itemId': serializer.toJson<int>(itemId),
      'qty': serializer.toJson<String>(qty),
      'description': serializer.toJson<String>(description),
    };
  }

  PartItem copyWith({
    int? partId,
    int? itemId,
    String? qty,
    String? description,
  }) => PartItem(
    partId: partId ?? this.partId,
    itemId: itemId ?? this.itemId,
    qty: qty ?? this.qty,
    description: description ?? this.description,
  );
  PartItem copyWithCompanion(PartItemsCompanion data) {
    return PartItem(
      partId: data.partId.present ? data.partId.value : this.partId,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      qty: data.qty.present ? data.qty.value : this.qty,
      description:
          data.description.present ? data.description.value : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PartItem(')
          ..write('partId: $partId, ')
          ..write('itemId: $itemId, ')
          ..write('qty: $qty, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(partId, itemId, qty, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PartItem &&
          other.partId == this.partId &&
          other.itemId == this.itemId &&
          other.qty == this.qty &&
          other.description == this.description);
}

class PartItemsCompanion extends UpdateCompanion<PartItem> {
  final Value<int> partId;
  final Value<int> itemId;
  final Value<String> qty;
  final Value<String> description;
  final Value<int> rowid;
  const PartItemsCompanion({
    this.partId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.qty = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PartItemsCompanion.insert({
    required int partId,
    required int itemId,
    required String qty,
    required String description,
    this.rowid = const Value.absent(),
  }) : partId = Value(partId),
       itemId = Value(itemId),
       qty = Value(qty),
       description = Value(description);
  static Insertable<PartItem> custom({
    Expression<int>? partId,
    Expression<int>? itemId,
    Expression<String>? qty,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (partId != null) 'part_id': partId,
      if (itemId != null) 'item_id': itemId,
      if (qty != null) 'qty': qty,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PartItemsCompanion copyWith({
    Value<int>? partId,
    Value<int>? itemId,
    Value<String>? qty,
    Value<String>? description,
    Value<int>? rowid,
  }) {
    return PartItemsCompanion(
      partId: partId ?? this.partId,
      itemId: itemId ?? this.itemId,
      qty: qty ?? this.qty,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (partId.present) {
      map['part_id'] = Variable<int>(partId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (qty.present) {
      map['qty'] = Variable<String>(qty.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PartItemsCompanion(')
          ..write('partId: $partId, ')
          ..write('itemId: $itemId, ')
          ..write('qty: $qty, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PartVehiclesTable extends PartVehicles
    with TableInfo<$PartVehiclesTable, PartVehicle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PartVehiclesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _partIdMeta = const VerificationMeta('partId');
  @override
  late final GeneratedColumn<int> partId = GeneratedColumn<int>(
    'part_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES parts (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<int> vehicleId = GeneratedColumn<int>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [partId, vehicleId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'part_vehicles';
  @override
  VerificationContext validateIntegrity(
    Insertable<PartVehicle> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('part_id')) {
      context.handle(
        _partIdMeta,
        partId.isAcceptableOrUnknown(data['part_id']!, _partIdMeta),
      );
    } else if (isInserting) {
      context.missing(_partIdMeta);
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {partId, vehicleId},
  ];
  @override
  PartVehicle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PartVehicle(
      partId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}part_id'],
          )!,
      vehicleId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}vehicle_id'],
          )!,
    );
  }

  @override
  $PartVehiclesTable createAlias(String alias) {
    return $PartVehiclesTable(attachedDatabase, alias);
  }
}

class PartVehicle extends DataClass implements Insertable<PartVehicle> {
  final int partId;
  final int vehicleId;
  const PartVehicle({required this.partId, required this.vehicleId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['part_id'] = Variable<int>(partId);
    map['vehicle_id'] = Variable<int>(vehicleId);
    return map;
  }

  PartVehiclesCompanion toCompanion(bool nullToAbsent) {
    return PartVehiclesCompanion(
      partId: Value(partId),
      vehicleId: Value(vehicleId),
    );
  }

  factory PartVehicle.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PartVehicle(
      partId: serializer.fromJson<int>(json['partId']),
      vehicleId: serializer.fromJson<int>(json['vehicleId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'partId': serializer.toJson<int>(partId),
      'vehicleId': serializer.toJson<int>(vehicleId),
    };
  }

  PartVehicle copyWith({int? partId, int? vehicleId}) => PartVehicle(
    partId: partId ?? this.partId,
    vehicleId: vehicleId ?? this.vehicleId,
  );
  PartVehicle copyWithCompanion(PartVehiclesCompanion data) {
    return PartVehicle(
      partId: data.partId.present ? data.partId.value : this.partId,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PartVehicle(')
          ..write('partId: $partId, ')
          ..write('vehicleId: $vehicleId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(partId, vehicleId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PartVehicle &&
          other.partId == this.partId &&
          other.vehicleId == this.vehicleId);
}

class PartVehiclesCompanion extends UpdateCompanion<PartVehicle> {
  final Value<int> partId;
  final Value<int> vehicleId;
  final Value<int> rowid;
  const PartVehiclesCompanion({
    this.partId = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PartVehiclesCompanion.insert({
    required int partId,
    required int vehicleId,
    this.rowid = const Value.absent(),
  }) : partId = Value(partId),
       vehicleId = Value(vehicleId);
  static Insertable<PartVehicle> custom({
    Expression<int>? partId,
    Expression<int>? vehicleId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (partId != null) 'part_id': partId,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PartVehiclesCompanion copyWith({
    Value<int>? partId,
    Value<int>? vehicleId,
    Value<int>? rowid,
  }) {
    return PartVehiclesCompanion(
      partId: partId ?? this.partId,
      vehicleId: vehicleId ?? this.vehicleId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (partId.present) {
      map['part_id'] = Variable<int>(partId.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<int>(vehicleId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PartVehiclesCompanion(')
          ..write('partId: $partId, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InheritedPartReplacementsTable extends InheritedPartReplacements
    with TableInfo<$InheritedPartReplacementsTable, InheritedPartReplacement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InheritedPartReplacementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<int> vehicleId = GeneratedColumn<int>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _inheritedPartIdMeta = const VerificationMeta(
    'inheritedPartId',
  );
  @override
  late final GeneratedColumn<int> inheritedPartId = GeneratedColumn<int>(
    'inherited_part_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES parts (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _replacementPartIdMeta = const VerificationMeta(
    'replacementPartId',
  );
  @override
  late final GeneratedColumn<int> replacementPartId = GeneratedColumn<int>(
    'replacement_part_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES parts (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    vehicleId,
    inheritedPartId,
    replacementPartId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inherited_part_replacements';
  @override
  VerificationContext validateIntegrity(
    Insertable<InheritedPartReplacement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('inherited_part_id')) {
      context.handle(
        _inheritedPartIdMeta,
        inheritedPartId.isAcceptableOrUnknown(
          data['inherited_part_id']!,
          _inheritedPartIdMeta,
        ),
      );
    }
    if (data.containsKey('replacement_part_id')) {
      context.handle(
        _replacementPartIdMeta,
        replacementPartId.isAcceptableOrUnknown(
          data['replacement_part_id']!,
          _replacementPartIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_replacementPartIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {vehicleId, inheritedPartId},
  ];
  @override
  InheritedPartReplacement map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InheritedPartReplacement(
      vehicleId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}vehicle_id'],
          )!,
      inheritedPartId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}inherited_part_id'],
      ),
      replacementPartId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}replacement_part_id'],
          )!,
    );
  }

  @override
  $InheritedPartReplacementsTable createAlias(String alias) {
    return $InheritedPartReplacementsTable(attachedDatabase, alias);
  }
}

class InheritedPartReplacement extends DataClass
    implements Insertable<InheritedPartReplacement> {
  final int vehicleId;
  final int? inheritedPartId;
  final int replacementPartId;
  const InheritedPartReplacement({
    required this.vehicleId,
    this.inheritedPartId,
    required this.replacementPartId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['vehicle_id'] = Variable<int>(vehicleId);
    if (!nullToAbsent || inheritedPartId != null) {
      map['inherited_part_id'] = Variable<int>(inheritedPartId);
    }
    map['replacement_part_id'] = Variable<int>(replacementPartId);
    return map;
  }

  InheritedPartReplacementsCompanion toCompanion(bool nullToAbsent) {
    return InheritedPartReplacementsCompanion(
      vehicleId: Value(vehicleId),
      inheritedPartId:
          inheritedPartId == null && nullToAbsent
              ? const Value.absent()
              : Value(inheritedPartId),
      replacementPartId: Value(replacementPartId),
    );
  }

  factory InheritedPartReplacement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InheritedPartReplacement(
      vehicleId: serializer.fromJson<int>(json['vehicleId']),
      inheritedPartId: serializer.fromJson<int?>(json['inheritedPartId']),
      replacementPartId: serializer.fromJson<int>(json['replacementPartId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'vehicleId': serializer.toJson<int>(vehicleId),
      'inheritedPartId': serializer.toJson<int?>(inheritedPartId),
      'replacementPartId': serializer.toJson<int>(replacementPartId),
    };
  }

  InheritedPartReplacement copyWith({
    int? vehicleId,
    Value<int?> inheritedPartId = const Value.absent(),
    int? replacementPartId,
  }) => InheritedPartReplacement(
    vehicleId: vehicleId ?? this.vehicleId,
    inheritedPartId:
        inheritedPartId.present ? inheritedPartId.value : this.inheritedPartId,
    replacementPartId: replacementPartId ?? this.replacementPartId,
  );
  InheritedPartReplacement copyWithCompanion(
    InheritedPartReplacementsCompanion data,
  ) {
    return InheritedPartReplacement(
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      inheritedPartId:
          data.inheritedPartId.present
              ? data.inheritedPartId.value
              : this.inheritedPartId,
      replacementPartId:
          data.replacementPartId.present
              ? data.replacementPartId.value
              : this.replacementPartId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InheritedPartReplacement(')
          ..write('vehicleId: $vehicleId, ')
          ..write('inheritedPartId: $inheritedPartId, ')
          ..write('replacementPartId: $replacementPartId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(vehicleId, inheritedPartId, replacementPartId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InheritedPartReplacement &&
          other.vehicleId == this.vehicleId &&
          other.inheritedPartId == this.inheritedPartId &&
          other.replacementPartId == this.replacementPartId);
}

class InheritedPartReplacementsCompanion
    extends UpdateCompanion<InheritedPartReplacement> {
  final Value<int> vehicleId;
  final Value<int?> inheritedPartId;
  final Value<int> replacementPartId;
  final Value<int> rowid;
  const InheritedPartReplacementsCompanion({
    this.vehicleId = const Value.absent(),
    this.inheritedPartId = const Value.absent(),
    this.replacementPartId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InheritedPartReplacementsCompanion.insert({
    required int vehicleId,
    this.inheritedPartId = const Value.absent(),
    required int replacementPartId,
    this.rowid = const Value.absent(),
  }) : vehicleId = Value(vehicleId),
       replacementPartId = Value(replacementPartId);
  static Insertable<InheritedPartReplacement> custom({
    Expression<int>? vehicleId,
    Expression<int>? inheritedPartId,
    Expression<int>? replacementPartId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (inheritedPartId != null) 'inherited_part_id': inheritedPartId,
      if (replacementPartId != null) 'replacement_part_id': replacementPartId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InheritedPartReplacementsCompanion copyWith({
    Value<int>? vehicleId,
    Value<int?>? inheritedPartId,
    Value<int>? replacementPartId,
    Value<int>? rowid,
  }) {
    return InheritedPartReplacementsCompanion(
      vehicleId: vehicleId ?? this.vehicleId,
      inheritedPartId: inheritedPartId ?? this.inheritedPartId,
      replacementPartId: replacementPartId ?? this.replacementPartId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<int>(vehicleId.value);
    }
    if (inheritedPartId.present) {
      map['inherited_part_id'] = Variable<int>(inheritedPartId.value);
    }
    if (replacementPartId.present) {
      map['replacement_part_id'] = Variable<int>(replacementPartId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InheritedPartReplacementsCompanion(')
          ..write('vehicleId: $vehicleId, ')
          ..write('inheritedPartId: $inheritedPartId, ')
          ..write('replacementPartId: $replacementPartId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $VehiclesTable vehicles = $VehiclesTable(this);
  late final $ItemsTable items = $ItemsTable(this);
  late final $PartsTable parts = $PartsTable(this);
  late final $PartItemsTable partItems = $PartItemsTable(this);
  late final $PartVehiclesTable partVehicles = $PartVehiclesTable(this);
  late final $InheritedPartReplacementsTable inheritedPartReplacements =
      $InheritedPartReplacementsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    vehicles,
    items,
    parts,
    partItems,
    partVehicles,
    inheritedPartReplacements,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'parts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('parts', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'parts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('part_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'parts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('part_vehicles', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vehicles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('part_vehicles', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vehicles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('inherited_part_replacements', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'parts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('inherited_part_replacements', kind: UpdateKind.update),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'parts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('inherited_part_replacements', kind: UpdateKind.delete),
      ],
    ),
  ]);
}

typedef $$VehiclesTableCreateCompanionBuilder =
    VehiclesCompanion Function({
      Value<int> id,
      required String name,
      required String description,
      Value<int?> parentId,
    });
typedef $$VehiclesTableUpdateCompanionBuilder =
    VehiclesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> description,
      Value<int?> parentId,
    });

final class $$VehiclesTableReferences
    extends BaseReferences<_$AppDatabase, $VehiclesTable, Vehicle> {
  $$VehiclesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiclesTable _parentIdTable(_$AppDatabase db) => db.vehicles
      .createAlias($_aliasNameGenerator(db.vehicles.parentId, db.vehicles.id));

  $$VehiclesTableProcessedTableManager? get parentId {
    final $_column = $_itemColumn<int>('parent_id');
    if ($_column == null) return null;
    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PartVehiclesTable, List<PartVehicle>>
  _partVehiclesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.partVehicles,
    aliasName: $_aliasNameGenerator(db.vehicles.id, db.partVehicles.vehicleId),
  );

  $$PartVehiclesTableProcessedTableManager get partVehiclesRefs {
    final manager = $$PartVehiclesTableTableManager(
      $_db,
      $_db.partVehicles,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_partVehiclesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $InheritedPartReplacementsTable,
    List<InheritedPartReplacement>
  >
  _inheritedPartReplacementsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.inheritedPartReplacements,
        aliasName: $_aliasNameGenerator(
          db.vehicles.id,
          db.inheritedPartReplacements.vehicleId,
        ),
      );

  $$InheritedPartReplacementsTableProcessedTableManager
  get inheritedPartReplacementsRefs {
    final manager = $$InheritedPartReplacementsTableTableManager(
      $_db,
      $_db.inheritedPartReplacements,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _inheritedPartReplacementsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VehiclesTableFilterComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get parentId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> partVehiclesRefs(
    Expression<bool> Function($$PartVehiclesTableFilterComposer f) f,
  ) {
    final $$PartVehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.partVehicles,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartVehiclesTableFilterComposer(
            $db: $db,
            $table: $db.partVehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> inheritedPartReplacementsRefs(
    Expression<bool> Function($$InheritedPartReplacementsTableFilterComposer f)
    f,
  ) {
    final $$InheritedPartReplacementsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inheritedPartReplacements,
          getReferencedColumn: (t) => t.vehicleId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InheritedPartReplacementsTableFilterComposer(
                $db: $db,
                $table: $db.inheritedPartReplacements,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$VehiclesTableOrderingComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get parentId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VehiclesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  $$VehiclesTableAnnotationComposer get parentId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> partVehiclesRefs<T extends Object>(
    Expression<T> Function($$PartVehiclesTableAnnotationComposer a) f,
  ) {
    final $$PartVehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.partVehicles,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartVehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.partVehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> inheritedPartReplacementsRefs<T extends Object>(
    Expression<T> Function($$InheritedPartReplacementsTableAnnotationComposer a)
    f,
  ) {
    final $$InheritedPartReplacementsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inheritedPartReplacements,
          getReferencedColumn: (t) => t.vehicleId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InheritedPartReplacementsTableAnnotationComposer(
                $db: $db,
                $table: $db.inheritedPartReplacements,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$VehiclesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VehiclesTable,
          Vehicle,
          $$VehiclesTableFilterComposer,
          $$VehiclesTableOrderingComposer,
          $$VehiclesTableAnnotationComposer,
          $$VehiclesTableCreateCompanionBuilder,
          $$VehiclesTableUpdateCompanionBuilder,
          (Vehicle, $$VehiclesTableReferences),
          Vehicle,
          PrefetchHooks Function({
            bool parentId,
            bool partVehiclesRefs,
            bool inheritedPartReplacementsRefs,
          })
        > {
  $$VehiclesTableTableManager(_$AppDatabase db, $VehiclesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$VehiclesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$VehiclesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$VehiclesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int?> parentId = const Value.absent(),
              }) => VehiclesCompanion(
                id: id,
                name: name,
                description: description,
                parentId: parentId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String description,
                Value<int?> parentId = const Value.absent(),
              }) => VehiclesCompanion.insert(
                id: id,
                name: name,
                description: description,
                parentId: parentId,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$VehiclesTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            parentId = false,
            partVehiclesRefs = false,
            inheritedPartReplacementsRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (partVehiclesRefs) db.partVehicles,
                if (inheritedPartReplacementsRefs) db.inheritedPartReplacements,
              ],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (parentId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.parentId,
                            referencedTable: $$VehiclesTableReferences
                                ._parentIdTable(db),
                            referencedColumn:
                                $$VehiclesTableReferences._parentIdTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (partVehiclesRefs)
                    await $_getPrefetchedData<
                      Vehicle,
                      $VehiclesTable,
                      PartVehicle
                    >(
                      currentTable: table,
                      referencedTable: $$VehiclesTableReferences
                          ._partVehiclesRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).partVehiclesRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.vehicleId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (inheritedPartReplacementsRefs)
                    await $_getPrefetchedData<
                      Vehicle,
                      $VehiclesTable,
                      InheritedPartReplacement
                    >(
                      currentTable: table,
                      referencedTable: $$VehiclesTableReferences
                          ._inheritedPartReplacementsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).inheritedPartReplacementsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.vehicleId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$VehiclesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VehiclesTable,
      Vehicle,
      $$VehiclesTableFilterComposer,
      $$VehiclesTableOrderingComposer,
      $$VehiclesTableAnnotationComposer,
      $$VehiclesTableCreateCompanionBuilder,
      $$VehiclesTableUpdateCompanionBuilder,
      (Vehicle, $$VehiclesTableReferences),
      Vehicle,
      PrefetchHooks Function({
        bool parentId,
        bool partVehiclesRefs,
        bool inheritedPartReplacementsRefs,
      })
    >;
typedef $$ItemsTableCreateCompanionBuilder =
    ItemsCompanion Function({
      Value<int> id,
      required String name,
      required String description,
    });
typedef $$ItemsTableUpdateCompanionBuilder =
    ItemsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> description,
    });

final class $$ItemsTableReferences
    extends BaseReferences<_$AppDatabase, $ItemsTable, Item> {
  $$ItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PartItemsTable, List<PartItem>>
  _partItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.partItems,
    aliasName: $_aliasNameGenerator(db.items.id, db.partItems.itemId),
  );

  $$PartItemsTableProcessedTableManager get partItemsRefs {
    final manager = $$PartItemsTableTableManager(
      $_db,
      $_db.partItems,
    ).filter((f) => f.itemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_partItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ItemsTableFilterComposer extends Composer<_$AppDatabase, $ItemsTable> {
  $$ItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> partItemsRefs(
    Expression<bool> Function($$PartItemsTableFilterComposer f) f,
  ) {
    final $$PartItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.partItems,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartItemsTableFilterComposer(
            $db: $db,
            $table: $db.partItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ItemsTable> {
  $$ItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItemsTable> {
  $$ItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  Expression<T> partItemsRefs<T extends Object>(
    Expression<T> Function($$PartItemsTableAnnotationComposer a) f,
  ) {
    final $$PartItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.partItems,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.partItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ItemsTable,
          Item,
          $$ItemsTableFilterComposer,
          $$ItemsTableOrderingComposer,
          $$ItemsTableAnnotationComposer,
          $$ItemsTableCreateCompanionBuilder,
          $$ItemsTableUpdateCompanionBuilder,
          (Item, $$ItemsTableReferences),
          Item,
          PrefetchHooks Function({bool partItemsRefs})
        > {
  $$ItemsTableTableManager(_$AppDatabase db, $ItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$ItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$ItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
              }) =>
                  ItemsCompanion(id: id, name: name, description: description),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String description,
              }) => ItemsCompanion.insert(
                id: id,
                name: name,
                description: description,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$ItemsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({partItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (partItemsRefs) db.partItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (partItemsRefs)
                    await $_getPrefetchedData<Item, $ItemsTable, PartItem>(
                      currentTable: table,
                      referencedTable: $$ItemsTableReferences
                          ._partItemsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$ItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).partItemsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) =>
                              referencedItems.where((e) => e.itemId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ItemsTable,
      Item,
      $$ItemsTableFilterComposer,
      $$ItemsTableOrderingComposer,
      $$ItemsTableAnnotationComposer,
      $$ItemsTableCreateCompanionBuilder,
      $$ItemsTableUpdateCompanionBuilder,
      (Item, $$ItemsTableReferences),
      Item,
      PrefetchHooks Function({bool partItemsRefs})
    >;
typedef $$PartsTableCreateCompanionBuilder =
    PartsCompanion Function({
      Value<int> id,
      required String name,
      required String description,
      Value<int?> parentId,
    });
typedef $$PartsTableUpdateCompanionBuilder =
    PartsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> description,
      Value<int?> parentId,
    });

final class $$PartsTableReferences
    extends BaseReferences<_$AppDatabase, $PartsTable, Part> {
  $$PartsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PartsTable _parentIdTable(_$AppDatabase db) => db.parts.createAlias(
    $_aliasNameGenerator(db.parts.parentId, db.parts.id),
  );

  $$PartsTableProcessedTableManager? get parentId {
    final $_column = $_itemColumn<int>('parent_id');
    if ($_column == null) return null;
    final manager = $$PartsTableTableManager(
      $_db,
      $_db.parts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PartItemsTable, List<PartItem>>
  _partItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.partItems,
    aliasName: $_aliasNameGenerator(db.parts.id, db.partItems.partId),
  );

  $$PartItemsTableProcessedTableManager get partItemsRefs {
    final manager = $$PartItemsTableTableManager(
      $_db,
      $_db.partItems,
    ).filter((f) => f.partId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_partItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PartVehiclesTable, List<PartVehicle>>
  _partVehiclesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.partVehicles,
    aliasName: $_aliasNameGenerator(db.parts.id, db.partVehicles.partId),
  );

  $$PartVehiclesTableProcessedTableManager get partVehiclesRefs {
    final manager = $$PartVehiclesTableTableManager(
      $_db,
      $_db.partVehicles,
    ).filter((f) => f.partId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_partVehiclesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PartsTableFilterComposer extends Composer<_$AppDatabase, $PartsTable> {
  $$PartsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  $$PartsTableFilterComposer get parentId {
    final $$PartsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.parts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartsTableFilterComposer(
            $db: $db,
            $table: $db.parts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> partItemsRefs(
    Expression<bool> Function($$PartItemsTableFilterComposer f) f,
  ) {
    final $$PartItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.partItems,
      getReferencedColumn: (t) => t.partId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartItemsTableFilterComposer(
            $db: $db,
            $table: $db.partItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> partVehiclesRefs(
    Expression<bool> Function($$PartVehiclesTableFilterComposer f) f,
  ) {
    final $$PartVehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.partVehicles,
      getReferencedColumn: (t) => t.partId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartVehiclesTableFilterComposer(
            $db: $db,
            $table: $db.partVehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PartsTableOrderingComposer
    extends Composer<_$AppDatabase, $PartsTable> {
  $$PartsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  $$PartsTableOrderingComposer get parentId {
    final $$PartsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.parts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartsTableOrderingComposer(
            $db: $db,
            $table: $db.parts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PartsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PartsTable> {
  $$PartsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  $$PartsTableAnnotationComposer get parentId {
    final $$PartsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.parts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartsTableAnnotationComposer(
            $db: $db,
            $table: $db.parts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> partItemsRefs<T extends Object>(
    Expression<T> Function($$PartItemsTableAnnotationComposer a) f,
  ) {
    final $$PartItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.partItems,
      getReferencedColumn: (t) => t.partId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.partItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> partVehiclesRefs<T extends Object>(
    Expression<T> Function($$PartVehiclesTableAnnotationComposer a) f,
  ) {
    final $$PartVehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.partVehicles,
      getReferencedColumn: (t) => t.partId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartVehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.partVehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PartsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PartsTable,
          Part,
          $$PartsTableFilterComposer,
          $$PartsTableOrderingComposer,
          $$PartsTableAnnotationComposer,
          $$PartsTableCreateCompanionBuilder,
          $$PartsTableUpdateCompanionBuilder,
          (Part, $$PartsTableReferences),
          Part,
          PrefetchHooks Function({
            bool parentId,
            bool partItemsRefs,
            bool partVehiclesRefs,
          })
        > {
  $$PartsTableTableManager(_$AppDatabase db, $PartsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$PartsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$PartsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$PartsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int?> parentId = const Value.absent(),
              }) => PartsCompanion(
                id: id,
                name: name,
                description: description,
                parentId: parentId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String description,
                Value<int?> parentId = const Value.absent(),
              }) => PartsCompanion.insert(
                id: id,
                name: name,
                description: description,
                parentId: parentId,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$PartsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            parentId = false,
            partItemsRefs = false,
            partVehiclesRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (partItemsRefs) db.partItems,
                if (partVehiclesRefs) db.partVehicles,
              ],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (parentId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.parentId,
                            referencedTable: $$PartsTableReferences
                                ._parentIdTable(db),
                            referencedColumn:
                                $$PartsTableReferences._parentIdTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (partItemsRefs)
                    await $_getPrefetchedData<Part, $PartsTable, PartItem>(
                      currentTable: table,
                      referencedTable: $$PartsTableReferences
                          ._partItemsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$PartsTableReferences(
                                db,
                                table,
                                p0,
                              ).partItemsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) =>
                              referencedItems.where((e) => e.partId == item.id),
                      typedResults: items,
                    ),
                  if (partVehiclesRefs)
                    await $_getPrefetchedData<Part, $PartsTable, PartVehicle>(
                      currentTable: table,
                      referencedTable: $$PartsTableReferences
                          ._partVehiclesRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$PartsTableReferences(
                                db,
                                table,
                                p0,
                              ).partVehiclesRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) =>
                              referencedItems.where((e) => e.partId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PartsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PartsTable,
      Part,
      $$PartsTableFilterComposer,
      $$PartsTableOrderingComposer,
      $$PartsTableAnnotationComposer,
      $$PartsTableCreateCompanionBuilder,
      $$PartsTableUpdateCompanionBuilder,
      (Part, $$PartsTableReferences),
      Part,
      PrefetchHooks Function({
        bool parentId,
        bool partItemsRefs,
        bool partVehiclesRefs,
      })
    >;
typedef $$PartItemsTableCreateCompanionBuilder =
    PartItemsCompanion Function({
      required int partId,
      required int itemId,
      required String qty,
      required String description,
      Value<int> rowid,
    });
typedef $$PartItemsTableUpdateCompanionBuilder =
    PartItemsCompanion Function({
      Value<int> partId,
      Value<int> itemId,
      Value<String> qty,
      Value<String> description,
      Value<int> rowid,
    });

final class $$PartItemsTableReferences
    extends BaseReferences<_$AppDatabase, $PartItemsTable, PartItem> {
  $$PartItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PartsTable _partIdTable(_$AppDatabase db) => db.parts.createAlias(
    $_aliasNameGenerator(db.partItems.partId, db.parts.id),
  );

  $$PartsTableProcessedTableManager get partId {
    final $_column = $_itemColumn<int>('part_id')!;

    final manager = $$PartsTableTableManager(
      $_db,
      $_db.parts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_partIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ItemsTable _itemIdTable(_$AppDatabase db) => db.items.createAlias(
    $_aliasNameGenerator(db.partItems.itemId, db.items.id),
  );

  $$ItemsTableProcessedTableManager get itemId {
    final $_column = $_itemColumn<int>('item_id')!;

    final manager = $$ItemsTableTableManager(
      $_db,
      $_db.items,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PartItemsTableFilterComposer
    extends Composer<_$AppDatabase, $PartItemsTable> {
  $$PartItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  $$PartsTableFilterComposer get partId {
    final $$PartsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partId,
      referencedTable: $db.parts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartsTableFilterComposer(
            $db: $db,
            $table: $db.parts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ItemsTableFilterComposer get itemId {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableFilterComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PartItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $PartItemsTable> {
  $$PartItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  $$PartsTableOrderingComposer get partId {
    final $$PartsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partId,
      referencedTable: $db.parts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartsTableOrderingComposer(
            $db: $db,
            $table: $db.parts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ItemsTableOrderingComposer get itemId {
    final $$ItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableOrderingComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PartItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PartItemsTable> {
  $$PartItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get qty =>
      $composableBuilder(column: $table.qty, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  $$PartsTableAnnotationComposer get partId {
    final $$PartsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partId,
      referencedTable: $db.parts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartsTableAnnotationComposer(
            $db: $db,
            $table: $db.parts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ItemsTableAnnotationComposer get itemId {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PartItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PartItemsTable,
          PartItem,
          $$PartItemsTableFilterComposer,
          $$PartItemsTableOrderingComposer,
          $$PartItemsTableAnnotationComposer,
          $$PartItemsTableCreateCompanionBuilder,
          $$PartItemsTableUpdateCompanionBuilder,
          (PartItem, $$PartItemsTableReferences),
          PartItem,
          PrefetchHooks Function({bool partId, bool itemId})
        > {
  $$PartItemsTableTableManager(_$AppDatabase db, $PartItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$PartItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$PartItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$PartItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> partId = const Value.absent(),
                Value<int> itemId = const Value.absent(),
                Value<String> qty = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PartItemsCompanion(
                partId: partId,
                itemId: itemId,
                qty: qty,
                description: description,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int partId,
                required int itemId,
                required String qty,
                required String description,
                Value<int> rowid = const Value.absent(),
              }) => PartItemsCompanion.insert(
                partId: partId,
                itemId: itemId,
                qty: qty,
                description: description,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$PartItemsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({partId = false, itemId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (partId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.partId,
                            referencedTable: $$PartItemsTableReferences
                                ._partIdTable(db),
                            referencedColumn:
                                $$PartItemsTableReferences._partIdTable(db).id,
                          )
                          as T;
                }
                if (itemId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.itemId,
                            referencedTable: $$PartItemsTableReferences
                                ._itemIdTable(db),
                            referencedColumn:
                                $$PartItemsTableReferences._itemIdTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PartItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PartItemsTable,
      PartItem,
      $$PartItemsTableFilterComposer,
      $$PartItemsTableOrderingComposer,
      $$PartItemsTableAnnotationComposer,
      $$PartItemsTableCreateCompanionBuilder,
      $$PartItemsTableUpdateCompanionBuilder,
      (PartItem, $$PartItemsTableReferences),
      PartItem,
      PrefetchHooks Function({bool partId, bool itemId})
    >;
typedef $$PartVehiclesTableCreateCompanionBuilder =
    PartVehiclesCompanion Function({
      required int partId,
      required int vehicleId,
      Value<int> rowid,
    });
typedef $$PartVehiclesTableUpdateCompanionBuilder =
    PartVehiclesCompanion Function({
      Value<int> partId,
      Value<int> vehicleId,
      Value<int> rowid,
    });

final class $$PartVehiclesTableReferences
    extends BaseReferences<_$AppDatabase, $PartVehiclesTable, PartVehicle> {
  $$PartVehiclesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PartsTable _partIdTable(_$AppDatabase db) => db.parts.createAlias(
    $_aliasNameGenerator(db.partVehicles.partId, db.parts.id),
  );

  $$PartsTableProcessedTableManager get partId {
    final $_column = $_itemColumn<int>('part_id')!;

    final manager = $$PartsTableTableManager(
      $_db,
      $_db.parts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_partIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias(
        $_aliasNameGenerator(db.partVehicles.vehicleId, db.vehicles.id),
      );

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<int>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PartVehiclesTableFilterComposer
    extends Composer<_$AppDatabase, $PartVehiclesTable> {
  $$PartVehiclesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PartsTableFilterComposer get partId {
    final $$PartsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partId,
      referencedTable: $db.parts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartsTableFilterComposer(
            $db: $db,
            $table: $db.parts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PartVehiclesTableOrderingComposer
    extends Composer<_$AppDatabase, $PartVehiclesTable> {
  $$PartVehiclesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PartsTableOrderingComposer get partId {
    final $$PartsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partId,
      referencedTable: $db.parts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartsTableOrderingComposer(
            $db: $db,
            $table: $db.parts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PartVehiclesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PartVehiclesTable> {
  $$PartVehiclesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PartsTableAnnotationComposer get partId {
    final $$PartsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partId,
      referencedTable: $db.parts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartsTableAnnotationComposer(
            $db: $db,
            $table: $db.parts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PartVehiclesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PartVehiclesTable,
          PartVehicle,
          $$PartVehiclesTableFilterComposer,
          $$PartVehiclesTableOrderingComposer,
          $$PartVehiclesTableAnnotationComposer,
          $$PartVehiclesTableCreateCompanionBuilder,
          $$PartVehiclesTableUpdateCompanionBuilder,
          (PartVehicle, $$PartVehiclesTableReferences),
          PartVehicle,
          PrefetchHooks Function({bool partId, bool vehicleId})
        > {
  $$PartVehiclesTableTableManager(_$AppDatabase db, $PartVehiclesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$PartVehiclesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$PartVehiclesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$PartVehiclesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> partId = const Value.absent(),
                Value<int> vehicleId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PartVehiclesCompanion(
                partId: partId,
                vehicleId: vehicleId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int partId,
                required int vehicleId,
                Value<int> rowid = const Value.absent(),
              }) => PartVehiclesCompanion.insert(
                partId: partId,
                vehicleId: vehicleId,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$PartVehiclesTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({partId = false, vehicleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (partId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.partId,
                            referencedTable: $$PartVehiclesTableReferences
                                ._partIdTable(db),
                            referencedColumn:
                                $$PartVehiclesTableReferences
                                    ._partIdTable(db)
                                    .id,
                          )
                          as T;
                }
                if (vehicleId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.vehicleId,
                            referencedTable: $$PartVehiclesTableReferences
                                ._vehicleIdTable(db),
                            referencedColumn:
                                $$PartVehiclesTableReferences
                                    ._vehicleIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PartVehiclesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PartVehiclesTable,
      PartVehicle,
      $$PartVehiclesTableFilterComposer,
      $$PartVehiclesTableOrderingComposer,
      $$PartVehiclesTableAnnotationComposer,
      $$PartVehiclesTableCreateCompanionBuilder,
      $$PartVehiclesTableUpdateCompanionBuilder,
      (PartVehicle, $$PartVehiclesTableReferences),
      PartVehicle,
      PrefetchHooks Function({bool partId, bool vehicleId})
    >;
typedef $$InheritedPartReplacementsTableCreateCompanionBuilder =
    InheritedPartReplacementsCompanion Function({
      required int vehicleId,
      Value<int?> inheritedPartId,
      required int replacementPartId,
      Value<int> rowid,
    });
typedef $$InheritedPartReplacementsTableUpdateCompanionBuilder =
    InheritedPartReplacementsCompanion Function({
      Value<int> vehicleId,
      Value<int?> inheritedPartId,
      Value<int> replacementPartId,
      Value<int> rowid,
    });

final class $$InheritedPartReplacementsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $InheritedPartReplacementsTable,
          InheritedPartReplacement
        > {
  $$InheritedPartReplacementsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias(
        $_aliasNameGenerator(
          db.inheritedPartReplacements.vehicleId,
          db.vehicles.id,
        ),
      );

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<int>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PartsTable _inheritedPartIdTable(_$AppDatabase db) =>
      db.parts.createAlias(
        $_aliasNameGenerator(
          db.inheritedPartReplacements.inheritedPartId,
          db.parts.id,
        ),
      );

  $$PartsTableProcessedTableManager? get inheritedPartId {
    final $_column = $_itemColumn<int>('inherited_part_id');
    if ($_column == null) return null;
    final manager = $$PartsTableTableManager(
      $_db,
      $_db.parts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_inheritedPartIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PartsTable _replacementPartIdTable(_$AppDatabase db) =>
      db.parts.createAlias(
        $_aliasNameGenerator(
          db.inheritedPartReplacements.replacementPartId,
          db.parts.id,
        ),
      );

  $$PartsTableProcessedTableManager get replacementPartId {
    final $_column = $_itemColumn<int>('replacement_part_id')!;

    final manager = $$PartsTableTableManager(
      $_db,
      $_db.parts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_replacementPartIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InheritedPartReplacementsTableFilterComposer
    extends Composer<_$AppDatabase, $InheritedPartReplacementsTable> {
  $$InheritedPartReplacementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PartsTableFilterComposer get inheritedPartId {
    final $$PartsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.inheritedPartId,
      referencedTable: $db.parts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartsTableFilterComposer(
            $db: $db,
            $table: $db.parts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PartsTableFilterComposer get replacementPartId {
    final $$PartsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.replacementPartId,
      referencedTable: $db.parts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartsTableFilterComposer(
            $db: $db,
            $table: $db.parts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InheritedPartReplacementsTableOrderingComposer
    extends Composer<_$AppDatabase, $InheritedPartReplacementsTable> {
  $$InheritedPartReplacementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PartsTableOrderingComposer get inheritedPartId {
    final $$PartsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.inheritedPartId,
      referencedTable: $db.parts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartsTableOrderingComposer(
            $db: $db,
            $table: $db.parts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PartsTableOrderingComposer get replacementPartId {
    final $$PartsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.replacementPartId,
      referencedTable: $db.parts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartsTableOrderingComposer(
            $db: $db,
            $table: $db.parts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InheritedPartReplacementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InheritedPartReplacementsTable> {
  $$InheritedPartReplacementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PartsTableAnnotationComposer get inheritedPartId {
    final $$PartsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.inheritedPartId,
      referencedTable: $db.parts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartsTableAnnotationComposer(
            $db: $db,
            $table: $db.parts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PartsTableAnnotationComposer get replacementPartId {
    final $$PartsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.replacementPartId,
      referencedTable: $db.parts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartsTableAnnotationComposer(
            $db: $db,
            $table: $db.parts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InheritedPartReplacementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InheritedPartReplacementsTable,
          InheritedPartReplacement,
          $$InheritedPartReplacementsTableFilterComposer,
          $$InheritedPartReplacementsTableOrderingComposer,
          $$InheritedPartReplacementsTableAnnotationComposer,
          $$InheritedPartReplacementsTableCreateCompanionBuilder,
          $$InheritedPartReplacementsTableUpdateCompanionBuilder,
          (
            InheritedPartReplacement,
            $$InheritedPartReplacementsTableReferences,
          ),
          InheritedPartReplacement,
          PrefetchHooks Function({
            bool vehicleId,
            bool inheritedPartId,
            bool replacementPartId,
          })
        > {
  $$InheritedPartReplacementsTableTableManager(
    _$AppDatabase db,
    $InheritedPartReplacementsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$InheritedPartReplacementsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$InheritedPartReplacementsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$InheritedPartReplacementsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> vehicleId = const Value.absent(),
                Value<int?> inheritedPartId = const Value.absent(),
                Value<int> replacementPartId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InheritedPartReplacementsCompanion(
                vehicleId: vehicleId,
                inheritedPartId: inheritedPartId,
                replacementPartId: replacementPartId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int vehicleId,
                Value<int?> inheritedPartId = const Value.absent(),
                required int replacementPartId,
                Value<int> rowid = const Value.absent(),
              }) => InheritedPartReplacementsCompanion.insert(
                vehicleId: vehicleId,
                inheritedPartId: inheritedPartId,
                replacementPartId: replacementPartId,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$InheritedPartReplacementsTableReferences(
                            db,
                            table,
                            e,
                          ),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            vehicleId = false,
            inheritedPartId = false,
            replacementPartId = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (vehicleId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.vehicleId,
                            referencedTable:
                                $$InheritedPartReplacementsTableReferences
                                    ._vehicleIdTable(db),
                            referencedColumn:
                                $$InheritedPartReplacementsTableReferences
                                    ._vehicleIdTable(db)
                                    .id,
                          )
                          as T;
                }
                if (inheritedPartId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.inheritedPartId,
                            referencedTable:
                                $$InheritedPartReplacementsTableReferences
                                    ._inheritedPartIdTable(db),
                            referencedColumn:
                                $$InheritedPartReplacementsTableReferences
                                    ._inheritedPartIdTable(db)
                                    .id,
                          )
                          as T;
                }
                if (replacementPartId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.replacementPartId,
                            referencedTable:
                                $$InheritedPartReplacementsTableReferences
                                    ._replacementPartIdTable(db),
                            referencedColumn:
                                $$InheritedPartReplacementsTableReferences
                                    ._replacementPartIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$InheritedPartReplacementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InheritedPartReplacementsTable,
      InheritedPartReplacement,
      $$InheritedPartReplacementsTableFilterComposer,
      $$InheritedPartReplacementsTableOrderingComposer,
      $$InheritedPartReplacementsTableAnnotationComposer,
      $$InheritedPartReplacementsTableCreateCompanionBuilder,
      $$InheritedPartReplacementsTableUpdateCompanionBuilder,
      (InheritedPartReplacement, $$InheritedPartReplacementsTableReferences),
      InheritedPartReplacement,
      PrefetchHooks Function({
        bool vehicleId,
        bool inheritedPartId,
        bool replacementPartId,
      })
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$VehiclesTableTableManager get vehicles =>
      $$VehiclesTableTableManager(_db, _db.vehicles);
  $$ItemsTableTableManager get items =>
      $$ItemsTableTableManager(_db, _db.items);
  $$PartsTableTableManager get parts =>
      $$PartsTableTableManager(_db, _db.parts);
  $$PartItemsTableTableManager get partItems =>
      $$PartItemsTableTableManager(_db, _db.partItems);
  $$PartVehiclesTableTableManager get partVehicles =>
      $$PartVehiclesTableTableManager(_db, _db.partVehicles);
  $$InheritedPartReplacementsTableTableManager get inheritedPartReplacements =>
      $$InheritedPartReplacementsTableTableManager(
        _db,
        _db.inheritedPartReplacements,
      );
}
