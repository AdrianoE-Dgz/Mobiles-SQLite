import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../models/tarea.dart';

part 'sqlite_handler.g.dart';

@DriftDatabase(tables: [TareaTabla])
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

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
  Future<bool> actualizarTarea(TareaTablaData tarea) {
    return update(tareaTabla).replace(tarea);
  }

  // TODO(AdrianoE-Dgz): Estado: marcar una tarea como completada o pendiente, actualizando la base de datos.
  Future<int> eliminarTarea(int id) {
    return (delete(tareaTabla)..where((tarea) => tarea.id.equals(id))).go();
  }

  // TODO(AdrianoE-Dgz): Eliminación: borrar una tarea utilizando su identificador; no debe reaparecer al reiniciar.
  // TODO(AdrianoE-Dgz): Sin conexión: todas las operaciones deben funcionar sin un servidor ni solicitudes HTTP.
  // TODO(AdrianoE-Dgz): Multiplataforma: diseñar la persistencia para Android, iOS, Windows, Linux, macOS y navegador, con el mismo proyecto Flutter.
  // TODO(AdrianoE-Dgz): Calidad: manejar errores de almacenamiento, liberar recursos cuando corresponda y evitar consultas a la base de datos dentro de build().

  Future<int> deleteAll() {
    return delete(tareaTabla).go();
  }
}

// Lazy loading de base de datos para permitir que cargue después de que carga la después de que comienze la aplicación
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app.db'));

    return NativeDatabase(file);
  });
}