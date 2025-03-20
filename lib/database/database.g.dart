// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CandidatesTable extends Candidates
    with TableInfo<$CandidatesTable, Candidate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CandidatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, password];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'candidates';
  @override
  VerificationContext validateIntegrity(Insertable<Candidate> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Candidate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Candidate(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password'])!,
    );
  }

  @override
  $CandidatesTable createAlias(String alias) {
    return $CandidatesTable(attachedDatabase, alias);
  }
}

class Candidate extends DataClass implements Insertable<Candidate> {
  final int id;
  final String name;
  final String password;
  const Candidate(
      {required this.id, required this.name, required this.password});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['password'] = Variable<String>(password);
    return map;
  }

  CandidatesCompanion toCompanion(bool nullToAbsent) {
    return CandidatesCompanion(
      id: Value(id),
      name: Value(name),
      password: Value(password),
    );
  }

  factory Candidate.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Candidate(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      password: serializer.fromJson<String>(json['password']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'password': serializer.toJson<String>(password),
    };
  }

  Candidate copyWith({int? id, String? name, String? password}) => Candidate(
        id: id ?? this.id,
        name: name ?? this.name,
        password: password ?? this.password,
      );
  Candidate copyWithCompanion(CandidatesCompanion data) {
    return Candidate(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      password: data.password.present ? data.password.value : this.password,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Candidate(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, password);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Candidate &&
          other.id == this.id &&
          other.name == this.name &&
          other.password == this.password);
}

class CandidatesCompanion extends UpdateCompanion<Candidate> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> password;
  const CandidatesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.password = const Value.absent(),
  });
  CandidatesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String password,
  })  : name = Value(name),
        password = Value(password);
  static Insertable<Candidate> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? password,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (password != null) 'password': password,
    });
  }

  CandidatesCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<String>? password}) {
    return CandidatesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      password: password ?? this.password,
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
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CandidatesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }
}

class $CandidateDetailsTable extends CandidateDetails
    with TableInfo<$CandidateDetailsTable, CandidateDetail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CandidateDetailsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _candidateIdMeta =
      const VerificationMeta('candidateId');
  @override
  late final GeneratedColumn<int> candidateId = GeneratedColumn<int>(
      'candidate_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES candidates (id)'));
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, candidateId, key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'candidate_details';
  @override
  VerificationContext validateIntegrity(Insertable<CandidateDetail> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('candidate_id')) {
      context.handle(
          _candidateIdMeta,
          candidateId.isAcceptableOrUnknown(
              data['candidate_id']!, _candidateIdMeta));
    } else if (isInserting) {
      context.missing(_candidateIdMeta);
    }
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CandidateDetail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CandidateDetail(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      candidateId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}candidate_id'])!,
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $CandidateDetailsTable createAlias(String alias) {
    return $CandidateDetailsTable(attachedDatabase, alias);
  }
}

class CandidateDetail extends DataClass implements Insertable<CandidateDetail> {
  final int id;
  final int candidateId;
  final String key;
  final String value;
  const CandidateDetail(
      {required this.id,
      required this.candidateId,
      required this.key,
      required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['candidate_id'] = Variable<int>(candidateId);
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  CandidateDetailsCompanion toCompanion(bool nullToAbsent) {
    return CandidateDetailsCompanion(
      id: Value(id),
      candidateId: Value(candidateId),
      key: Value(key),
      value: Value(value),
    );
  }

  factory CandidateDetail.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CandidateDetail(
      id: serializer.fromJson<int>(json['id']),
      candidateId: serializer.fromJson<int>(json['candidateId']),
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'candidateId': serializer.toJson<int>(candidateId),
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  CandidateDetail copyWith(
          {int? id, int? candidateId, String? key, String? value}) =>
      CandidateDetail(
        id: id ?? this.id,
        candidateId: candidateId ?? this.candidateId,
        key: key ?? this.key,
        value: value ?? this.value,
      );
  CandidateDetail copyWithCompanion(CandidateDetailsCompanion data) {
    return CandidateDetail(
      id: data.id.present ? data.id.value : this.id,
      candidateId:
          data.candidateId.present ? data.candidateId.value : this.candidateId,
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CandidateDetail(')
          ..write('id: $id, ')
          ..write('candidateId: $candidateId, ')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, candidateId, key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CandidateDetail &&
          other.id == this.id &&
          other.candidateId == this.candidateId &&
          other.key == this.key &&
          other.value == this.value);
}

class CandidateDetailsCompanion extends UpdateCompanion<CandidateDetail> {
  final Value<int> id;
  final Value<int> candidateId;
  final Value<String> key;
  final Value<String> value;
  const CandidateDetailsCompanion({
    this.id = const Value.absent(),
    this.candidateId = const Value.absent(),
    this.key = const Value.absent(),
    this.value = const Value.absent(),
  });
  CandidateDetailsCompanion.insert({
    this.id = const Value.absent(),
    required int candidateId,
    required String key,
    required String value,
  })  : candidateId = Value(candidateId),
        key = Value(key),
        value = Value(value);
  static Insertable<CandidateDetail> custom({
    Expression<int>? id,
    Expression<int>? candidateId,
    Expression<String>? key,
    Expression<String>? value,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (candidateId != null) 'candidate_id': candidateId,
      if (key != null) 'key': key,
      if (value != null) 'value': value,
    });
  }

  CandidateDetailsCompanion copyWith(
      {Value<int>? id,
      Value<int>? candidateId,
      Value<String>? key,
      Value<String>? value}) {
    return CandidateDetailsCompanion(
      id: id ?? this.id,
      candidateId: candidateId ?? this.candidateId,
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (candidateId.present) {
      map['candidate_id'] = Variable<int>(candidateId.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CandidateDetailsCompanion(')
          ..write('id: $id, ')
          ..write('candidateId: $candidateId, ')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CandidatesTable candidates = $CandidatesTable(this);
  late final $CandidateDetailsTable candidateDetails =
      $CandidateDetailsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [candidates, candidateDetails];
}

typedef $$CandidatesTableCreateCompanionBuilder = CandidatesCompanion Function({
  Value<int> id,
  required String name,
  required String password,
});
typedef $$CandidatesTableUpdateCompanionBuilder = CandidatesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> password,
});

final class $$CandidatesTableReferences
    extends BaseReferences<_$AppDatabase, $CandidatesTable, Candidate> {
  $$CandidatesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CandidateDetailsTable, List<CandidateDetail>>
      _candidateDetailsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.candidateDetails,
              aliasName: $_aliasNameGenerator(
                  db.candidates.id, db.candidateDetails.candidateId));

  $$CandidateDetailsTableProcessedTableManager get candidateDetailsRefs {
    final manager = $$CandidateDetailsTableTableManager(
            $_db, $_db.candidateDetails)
        .filter((f) => f.candidateId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_candidateDetailsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CandidatesTableFilterComposer
    extends Composer<_$AppDatabase, $CandidatesTable> {
  $$CandidatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get password => $composableBuilder(
      column: $table.password, builder: (column) => ColumnFilters(column));

  Expression<bool> candidateDetailsRefs(
      Expression<bool> Function($$CandidateDetailsTableFilterComposer f) f) {
    final $$CandidateDetailsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.candidateDetails,
        getReferencedColumn: (t) => t.candidateId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CandidateDetailsTableFilterComposer(
              $db: $db,
              $table: $db.candidateDetails,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CandidatesTableOrderingComposer
    extends Composer<_$AppDatabase, $CandidatesTable> {
  $$CandidatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get password => $composableBuilder(
      column: $table.password, builder: (column) => ColumnOrderings(column));
}

class $$CandidatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CandidatesTable> {
  $$CandidatesTableAnnotationComposer({
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

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  Expression<T> candidateDetailsRefs<T extends Object>(
      Expression<T> Function($$CandidateDetailsTableAnnotationComposer a) f) {
    final $$CandidateDetailsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.candidateDetails,
        getReferencedColumn: (t) => t.candidateId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CandidateDetailsTableAnnotationComposer(
              $db: $db,
              $table: $db.candidateDetails,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CandidatesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CandidatesTable,
    Candidate,
    $$CandidatesTableFilterComposer,
    $$CandidatesTableOrderingComposer,
    $$CandidatesTableAnnotationComposer,
    $$CandidatesTableCreateCompanionBuilder,
    $$CandidatesTableUpdateCompanionBuilder,
    (Candidate, $$CandidatesTableReferences),
    Candidate,
    PrefetchHooks Function({bool candidateDetailsRefs})> {
  $$CandidatesTableTableManager(_$AppDatabase db, $CandidatesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CandidatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CandidatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CandidatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> password = const Value.absent(),
          }) =>
              CandidatesCompanion(
            id: id,
            name: name,
            password: password,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String password,
          }) =>
              CandidatesCompanion.insert(
            id: id,
            name: name,
            password: password,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CandidatesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({candidateDetailsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (candidateDetailsRefs) db.candidateDetails
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (candidateDetailsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$CandidatesTableReferences
                            ._candidateDetailsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CandidatesTableReferences(db, table, p0)
                                .candidateDetailsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.candidateId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CandidatesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CandidatesTable,
    Candidate,
    $$CandidatesTableFilterComposer,
    $$CandidatesTableOrderingComposer,
    $$CandidatesTableAnnotationComposer,
    $$CandidatesTableCreateCompanionBuilder,
    $$CandidatesTableUpdateCompanionBuilder,
    (Candidate, $$CandidatesTableReferences),
    Candidate,
    PrefetchHooks Function({bool candidateDetailsRefs})>;
typedef $$CandidateDetailsTableCreateCompanionBuilder
    = CandidateDetailsCompanion Function({
  Value<int> id,
  required int candidateId,
  required String key,
  required String value,
});
typedef $$CandidateDetailsTableUpdateCompanionBuilder
    = CandidateDetailsCompanion Function({
  Value<int> id,
  Value<int> candidateId,
  Value<String> key,
  Value<String> value,
});

final class $$CandidateDetailsTableReferences extends BaseReferences<
    _$AppDatabase, $CandidateDetailsTable, CandidateDetail> {
  $$CandidateDetailsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $CandidatesTable _candidateIdTable(_$AppDatabase db) =>
      db.candidates.createAlias($_aliasNameGenerator(
          db.candidateDetails.candidateId, db.candidates.id));

  $$CandidatesTableProcessedTableManager get candidateId {
    final $_column = $_itemColumn<int>('candidate_id')!;

    final manager = $$CandidatesTableTableManager($_db, $_db.candidates)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_candidateIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CandidateDetailsTableFilterComposer
    extends Composer<_$AppDatabase, $CandidateDetailsTable> {
  $$CandidateDetailsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  $$CandidatesTableFilterComposer get candidateId {
    final $$CandidatesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.candidateId,
        referencedTable: $db.candidates,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CandidatesTableFilterComposer(
              $db: $db,
              $table: $db.candidates,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CandidateDetailsTableOrderingComposer
    extends Composer<_$AppDatabase, $CandidateDetailsTable> {
  $$CandidateDetailsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  $$CandidatesTableOrderingComposer get candidateId {
    final $$CandidatesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.candidateId,
        referencedTable: $db.candidates,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CandidatesTableOrderingComposer(
              $db: $db,
              $table: $db.candidates,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CandidateDetailsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CandidateDetailsTable> {
  $$CandidateDetailsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  $$CandidatesTableAnnotationComposer get candidateId {
    final $$CandidatesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.candidateId,
        referencedTable: $db.candidates,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CandidatesTableAnnotationComposer(
              $db: $db,
              $table: $db.candidates,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CandidateDetailsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CandidateDetailsTable,
    CandidateDetail,
    $$CandidateDetailsTableFilterComposer,
    $$CandidateDetailsTableOrderingComposer,
    $$CandidateDetailsTableAnnotationComposer,
    $$CandidateDetailsTableCreateCompanionBuilder,
    $$CandidateDetailsTableUpdateCompanionBuilder,
    (CandidateDetail, $$CandidateDetailsTableReferences),
    CandidateDetail,
    PrefetchHooks Function({bool candidateId})> {
  $$CandidateDetailsTableTableManager(
      _$AppDatabase db, $CandidateDetailsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CandidateDetailsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CandidateDetailsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CandidateDetailsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> candidateId = const Value.absent(),
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
          }) =>
              CandidateDetailsCompanion(
            id: id,
            candidateId: candidateId,
            key: key,
            value: value,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int candidateId,
            required String key,
            required String value,
          }) =>
              CandidateDetailsCompanion.insert(
            id: id,
            candidateId: candidateId,
            key: key,
            value: value,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CandidateDetailsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({candidateId = false}) {
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
                      dynamic>>(state) {
                if (candidateId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.candidateId,
                    referencedTable:
                        $$CandidateDetailsTableReferences._candidateIdTable(db),
                    referencedColumn: $$CandidateDetailsTableReferences
                        ._candidateIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$CandidateDetailsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CandidateDetailsTable,
    CandidateDetail,
    $$CandidateDetailsTableFilterComposer,
    $$CandidateDetailsTableOrderingComposer,
    $$CandidateDetailsTableAnnotationComposer,
    $$CandidateDetailsTableCreateCompanionBuilder,
    $$CandidateDetailsTableUpdateCompanionBuilder,
    (CandidateDetail, $$CandidateDetailsTableReferences),
    CandidateDetail,
    PrefetchHooks Function({bool candidateId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CandidatesTableTableManager get candidates =>
      $$CandidatesTableTableManager(_db, _db.candidates);
  $$CandidateDetailsTableTableManager get candidateDetails =>
      $$CandidateDetailsTableTableManager(_db, _db.candidateDetails);
}
