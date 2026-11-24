// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sqlite_handler.dart';

// ignore_for_file: type=lint
class $TareaTablaTable extends TareaTabla
    with TableInfo<$TareaTablaTable, TareaTablaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TareaTablaTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _tituloMeta = const VerificationMeta('titulo');
  @override
  late final GeneratedColumn<String> titulo = GeneratedColumn<String>(
    'titulo',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 30),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completadaMeta = const VerificationMeta(
    'completada',
  );
  @override
  late final GeneratedColumn<bool> completada = GeneratedColumn<bool>(
    'completada',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("completada" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, titulo, completada];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tarea_tabla';
  @override
  VerificationContext validateIntegrity(
    Insertable<TareaTablaData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('titulo')) {
      context.handle(
        _tituloMeta,
        titulo.isAcceptableOrUnknown(data['titulo']!, _tituloMeta),
      );
    } else if (isInserting) {
      context.missing(_tituloMeta);
    }
    if (data.containsKey('completada')) {
      context.handle(
        _completadaMeta,
        completada.isAcceptableOrUnknown(data['completada']!, _completadaMeta),
      );
    } else if (isInserting) {
      context.missing(_completadaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TareaTablaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TareaTablaData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      titulo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}titulo'],
      )!,
      completada: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}completada'],
      )!,
    );
  }

  @override
  $TareaTablaTable createAlias(String alias) {
    return $TareaTablaTable(attachedDatabase, alias);
  }
}

class TareaTablaData extends DataClass implements Insertable<TareaTablaData> {
  final int id;
  final String titulo;
  final bool completada;
  const TareaTablaData({
    required this.id,
    required this.titulo,
    required this.completada,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['titulo'] = Variable<String>(titulo);
    map['completada'] = Variable<bool>(completada);
    return map;
  }

  TareaTablaCompanion toCompanion(bool nullToAbsent) {
    return TareaTablaCompanion(
      id: Value(id),
      titulo: Value(titulo),
      completada: Value(completada),
    );
  }

  factory TareaTablaData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TareaTablaData(
      id: serializer.fromJson<int>(json['id']),
      titulo: serializer.fromJson<String>(json['titulo']),
      completada: serializer.fromJson<bool>(json['completada']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'titulo': serializer.toJson<String>(titulo),
      'completada': serializer.toJson<bool>(completada),
    };
  }

  TareaTablaData copyWith({int? id, String? titulo, bool? completada}) =>
      TareaTablaData(
        id: id ?? this.id,
        titulo: titulo ?? this.titulo,
        completada: completada ?? this.completada,
      );
  TareaTablaData copyWithCompanion(TareaTablaCompanion data) {
    return TareaTablaData(
      id: data.id.present ? data.id.value : this.id,
      titulo: data.titulo.present ? data.titulo.value : this.titulo,
      completada: data.completada.present
          ? data.completada.value
          : this.completada,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TareaTablaData(')
          ..write('id: $id, ')
          ..write('titulo: $titulo, ')
          ..write('completada: $completada')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, titulo, completada);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TareaTablaData &&
          other.id == this.id &&
          other.titulo == this.titulo &&
          other.completada == this.completada);
}

class TareaTablaCompanion extends UpdateCompanion<TareaTablaData> {
  final Value<int> id;
  final Value<String> titulo;
  final Value<bool> completada;
  const TareaTablaCompanion({
    this.id = const Value.absent(),
    this.titulo = const Value.absent(),
    this.completada = const Value.absent(),
  });
  TareaTablaCompanion.insert({
    this.id = const Value.absent(),
    required String titulo,
    required bool completada,
  }) : titulo = Value(titulo),
       completada = Value(completada);
  static Insertable<TareaTablaData> custom({
    Expression<int>? id,
    Expression<String>? titulo,
    Expression<bool>? completada,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (titulo != null) 'titulo': titulo,
      if (completada != null) 'completada': completada,
    });
  }

  TareaTablaCompanion copyWith({
    Value<int>? id,
    Value<String>? titulo,
    Value<bool>? completada,
  }) {
    return TareaTablaCompanion(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      completada: completada ?? this.completada,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (titulo.present) {
      map['titulo'] = Variable<String>(titulo.value);
    }
    if (completada.present) {
      map['completada'] = Variable<bool>(completada.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TareaTablaCompanion(')
          ..write('id: $id, ')
          ..write('titulo: $titulo, ')
          ..write('completada: $completada')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TareaTablaTable tareaTabla = $TareaTablaTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tareaTabla];
}

typedef $$TareaTablaTableCreateCompanionBuilder = TareaTablaCompanion Function({
  Value<int> id,
  required String titulo,
  required bool completada,
});
typedef $$TareaTablaTableUpdateCompanionBuilder = TareaTablaCompanion Function({
  Value<int> id,
  Value<String> titulo,
  Value<bool> completada,
});

class $$TareaTablaTableFilterComposer
    extends Composer<_$AppDatabase, $TareaTablaTable> {
  $$TareaTablaTableFilterComposer({
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

  ColumnFilters<String> get titulo => $composableBuilder(
    column: $table.titulo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get completada => $composableBuilder(
    column: $table.completada,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TareaTablaTableOrderingComposer
    extends Composer<_$AppDatabase, $TareaTablaTable> {
  $$TareaTablaTableOrderingComposer({
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

  ColumnOrderings<String> get titulo => $composableBuilder(
    column: $table.titulo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get completada => $composableBuilder(
    column: $table.completada,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TareaTablaTableAnnotationComposer
    extends Composer<_$AppDatabase, $TareaTablaTable> {
  $$TareaTablaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get titulo =>
      $composableBuilder(column: $table.titulo, builder: (column) => column);

  GeneratedColumn<bool> get completada => $composableBuilder(
    column: $table.completada,
    builder: (column) => column,
  );
}

class $$TareaTablaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TareaTablaTable,
          TareaTablaData,
          $$TareaTablaTableFilterComposer,
          $$TareaTablaTableOrderingComposer,
          $$TareaTablaTableAnnotationComposer,
          $$TareaTablaTableCreateCompanionBuilder,
          $$TareaTablaTableUpdateCompanionBuilder,
          (
            TareaTablaData,
            BaseReferences<_$AppDatabase, $TareaTablaTable, TareaTablaData>,
          ),
          TareaTablaData,
          PrefetchHooks Function()
        > {
  $$TareaTablaTableTableManager(_$AppDatabase db, $TareaTablaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TareaTablaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TareaTablaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TareaTablaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> titulo = const Value.absent(),
                Value<bool> completada = const Value.absent(),
              }) => TareaTablaCompanion(
                id: id,
                titulo: titulo,
                completada: completada,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String titulo,
                required bool completada,
              }) => TareaTablaCompanion.insert(
                id: id,
                titulo: titulo,
                completada: completada,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TareaTablaTable, TareaTablaData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $TareaTablaTable,
                    TareaTablaData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TareaTablaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TareaTablaTable,
      TareaTablaData,
      $$TareaTablaTableFilterComposer,
      $$TareaTablaTableOrderingComposer,
      $$TareaTablaTableAnnotationComposer,
      $$TareaTablaTableCreateCompanionBuilder,
      $$TareaTablaTableUpdateCompanionBuilder,
      (
        TareaTablaData,
        BaseReferences<_$AppDatabase, $TareaTablaTable, TareaTablaData>,
      ),
      TareaTablaData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TareaTablaTableTableManager get tareaTabla =>
      $$TareaTablaTableTableManager(_db, _db.tareaTabla);
}
