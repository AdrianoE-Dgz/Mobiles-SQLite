import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../models/tarea.dart';

part 'sqlite_handler.g.dart';

@DriftDatabase(tables: [TareaTabla])
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.dart.js'),
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }

  // DONE(AdrianoE-Dgz): Alta escribir un título y guardar una tarea nueva en SQLite. Rechazar títulos vacíos o compuestos solamente por espacios.
  Future<int> insertarTarea(TareaTablaCompanion tarea) async {
    if(tarea.titulo.value.isEmpty) {
      return -1;
    }

    return into(tareaTabla).insert(tarea);
  }

  // DONE(AdrianoE-Dgz): Consulta: mostrar las tareas guardadas, incluyendo su título y estado, aun después de cerrar y volver a abrir la aplicación.
  Future<List<TareaTablaData>> getAllTareas() {
    return select(tareaTabla).get();
  }

  // TODO(AdrianoE-Dgz): Edición: modificar el título de una tarea existente y conservar el cambio tras reiniciar.
  Future<bool> modificarTarea(TareaTablaData tarea) {
    return update(tareaTabla).replace(tarea);
  }

  // DONE(AdrianoE-Dgz): Estado: marcar una tarea como completada o pendiente, actualizando la base de datos.
  Future<bool> actualizarTarea(TareaTablaData tarea) {
    return update(tareaTabla).replace(tarea);
  }

  // DONE(AdrianoE-Dgz): Eliminación: borrar una tarea utilizando su identificador; no debe reaparecer al reiniciar.
  Future<int> eliminarTarea(int id) {
    return (delete(tareaTabla)..where((tarea) => tarea.id.equals(id))).go();
  }

  // TODO(AdrianoE-Dgz): Sin conexión: todas las operaciones deben funcionar sin un servidor ni solicitudes HTTP.
  // TODO(AdrianoE-Dgz): Multiplataforma: diseñar la persistencia para Android, iOS, Windows, Linux, macOS y navegador, con el mismo proyecto Flutter.
  // TODO(AdrianoE-Dgz): Calidad: manejar errores de almacenamiento, liberar recursos cuando corresponda y evitar consultas a la base de datos dentro de build().

  Future<int> deleteAll() {
    return delete(tareaTabla).go();
  }
}