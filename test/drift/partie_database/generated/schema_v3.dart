// dart format width=80
// GENERATED CODE, DO NOT EDIT BY HAND.
// ignore_for_file: type=lint
import 'package:drift/drift.dart';

class Vehicles extends Table with TableInfo<Vehicles, VehiclesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Vehicles(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VehiclesData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VehiclesData(
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
  Vehicles createAlias(String alias) {
    return Vehicles(attachedDatabase, alias);
  }
}

class VehiclesData extends DataClass implements Insertable<VehiclesData> {
  final int id;
  final String name;
  final String description;
  final int? parentId;
  const VehiclesData({
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

  factory VehiclesData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VehiclesData(
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

  VehiclesData copyWith({
    int? id,
    String? name,
    String? description,
    Value<int?> parentId = const Value.absent(),
  }) => VehiclesData(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    parentId: parentId.present ? parentId.value : this.parentId,
  );
  VehiclesData copyWithCompanion(VehiclesCompanion data) {
    return VehiclesData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VehiclesData(')
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
      (other is VehiclesData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.parentId == this.parentId);
}

class VehiclesCompanion extends UpdateCompanion<VehiclesData> {
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
  static Insertable<VehiclesData> custom({
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

class Items extends Table with TableInfo<Items, ItemsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Items(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ItemsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItemsData(
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
  Items createAlias(String alias) {
    return Items(attachedDatabase, alias);
  }
}

class ItemsData extends DataClass implements Insertable<ItemsData> {
  final int id;
  final String name;
  final String description;
  const ItemsData({
    required this.id,
    required this.name,
    required this.description,
  });
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

  factory ItemsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItemsData(
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

  ItemsData copyWith({int? id, String? name, String? description}) => ItemsData(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
  );
  ItemsData copyWithCompanion(ItemsCompanion data) {
    return ItemsData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ItemsData(')
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
      (other is ItemsData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description);
}

class ItemsCompanion extends UpdateCompanion<ItemsData> {
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
  static Insertable<ItemsData> custom({
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

class Parts extends Table with TableInfo<Parts, PartsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Parts(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PartsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PartsData(
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
  Parts createAlias(String alias) {
    return Parts(attachedDatabase, alias);
  }
}

class PartsData extends DataClass implements Insertable<PartsData> {
  final int id;
  final String name;
  final String description;
  final int? parentId;
  const PartsData({
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

  factory PartsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PartsData(
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

  PartsData copyWith({
    int? id,
    String? name,
    String? description,
    Value<int?> parentId = const Value.absent(),
  }) => PartsData(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    parentId: parentId.present ? parentId.value : this.parentId,
  );
  PartsData copyWithCompanion(PartsCompanion data) {
    return PartsData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PartsData(')
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
      (other is PartsData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.parentId == this.parentId);
}

class PartsCompanion extends UpdateCompanion<PartsData> {
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
  static Insertable<PartsData> custom({
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

class PartItems extends Table with TableInfo<PartItems, PartItemsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  PartItems(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumn<String> qty = GeneratedColumn<String>(
    'qty',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
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
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  PartItemsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PartItemsData(
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
  PartItems createAlias(String alias) {
    return PartItems(attachedDatabase, alias);
  }
}

class PartItemsData extends DataClass implements Insertable<PartItemsData> {
  final int partId;
  final int itemId;
  final String qty;
  final String description;
  const PartItemsData({
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

  factory PartItemsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PartItemsData(
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

  PartItemsData copyWith({
    int? partId,
    int? itemId,
    String? qty,
    String? description,
  }) => PartItemsData(
    partId: partId ?? this.partId,
    itemId: itemId ?? this.itemId,
    qty: qty ?? this.qty,
    description: description ?? this.description,
  );
  PartItemsData copyWithCompanion(PartItemsCompanion data) {
    return PartItemsData(
      partId: data.partId.present ? data.partId.value : this.partId,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      qty: data.qty.present ? data.qty.value : this.qty,
      description:
          data.description.present ? data.description.value : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PartItemsData(')
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
      (other is PartItemsData &&
          other.partId == this.partId &&
          other.itemId == this.itemId &&
          other.qty == this.qty &&
          other.description == this.description);
}

class PartItemsCompanion extends UpdateCompanion<PartItemsData> {
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
  static Insertable<PartItemsData> custom({
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

class PartVehicles extends Table
    with TableInfo<PartVehicles, PartVehiclesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  PartVehicles(this.attachedDatabase, [this._alias]);
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
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {partId, vehicleId},
  ];
  @override
  PartVehiclesData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PartVehiclesData(
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
  PartVehicles createAlias(String alias) {
    return PartVehicles(attachedDatabase, alias);
  }
}

class PartVehiclesData extends DataClass
    implements Insertable<PartVehiclesData> {
  final int partId;
  final int vehicleId;
  const PartVehiclesData({required this.partId, required this.vehicleId});
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

  factory PartVehiclesData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PartVehiclesData(
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

  PartVehiclesData copyWith({int? partId, int? vehicleId}) => PartVehiclesData(
    partId: partId ?? this.partId,
    vehicleId: vehicleId ?? this.vehicleId,
  );
  PartVehiclesData copyWithCompanion(PartVehiclesCompanion data) {
    return PartVehiclesData(
      partId: data.partId.present ? data.partId.value : this.partId,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PartVehiclesData(')
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
      (other is PartVehiclesData &&
          other.partId == this.partId &&
          other.vehicleId == this.vehicleId);
}

class PartVehiclesCompanion extends UpdateCompanion<PartVehiclesData> {
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
  static Insertable<PartVehiclesData> custom({
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

class InheritedPartReplacements extends Table
    with TableInfo<InheritedPartReplacements, InheritedPartReplacementsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  InheritedPartReplacements(this.attachedDatabase, [this._alias]);
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
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {vehicleId, inheritedPartId},
  ];
  @override
  InheritedPartReplacementsData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InheritedPartReplacementsData(
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
  InheritedPartReplacements createAlias(String alias) {
    return InheritedPartReplacements(attachedDatabase, alias);
  }
}

class InheritedPartReplacementsData extends DataClass
    implements Insertable<InheritedPartReplacementsData> {
  final int vehicleId;
  final int? inheritedPartId;
  final int replacementPartId;
  const InheritedPartReplacementsData({
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

  factory InheritedPartReplacementsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InheritedPartReplacementsData(
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

  InheritedPartReplacementsData copyWith({
    int? vehicleId,
    Value<int?> inheritedPartId = const Value.absent(),
    int? replacementPartId,
  }) => InheritedPartReplacementsData(
    vehicleId: vehicleId ?? this.vehicleId,
    inheritedPartId:
        inheritedPartId.present ? inheritedPartId.value : this.inheritedPartId,
    replacementPartId: replacementPartId ?? this.replacementPartId,
  );
  InheritedPartReplacementsData copyWithCompanion(
    InheritedPartReplacementsCompanion data,
  ) {
    return InheritedPartReplacementsData(
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
    return (StringBuffer('InheritedPartReplacementsData(')
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
      (other is InheritedPartReplacementsData &&
          other.vehicleId == this.vehicleId &&
          other.inheritedPartId == this.inheritedPartId &&
          other.replacementPartId == this.replacementPartId);
}

class InheritedPartReplacementsCompanion
    extends UpdateCompanion<InheritedPartReplacementsData> {
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
  static Insertable<InheritedPartReplacementsData> custom({
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

class DatabaseAtV3 extends GeneratedDatabase {
  DatabaseAtV3(QueryExecutor e) : super(e);
  late final Vehicles vehicles = Vehicles(this);
  late final Items items = Items(this);
  late final Parts parts = Parts(this);
  late final PartItems partItems = PartItems(this);
  late final PartVehicles partVehicles = PartVehicles(this);
  late final InheritedPartReplacements inheritedPartReplacements =
      InheritedPartReplacements(this);
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
  int get schemaVersion => 3;
}
