import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../models/tarea.dart';

part 'sqlite_handler.g.dart';

// TODO(AdrianoE-Dgz): Alta escribir un título y guardar una tarea nueva en SQLite. Rechazar títulos vacíos o compuestos solamente por espacios.
// TODO(AdrianoE-Dgz): Consulta: mostrar las tareas guardadas, incluyendo su título y estado, aun después de cerrar y volver a abrir la aplicación.
// TODO(AdrianoE-Dgz): Edición: modificar el título de una tarea existente y conservar el cambio tras reiniciar.
// TODO(AdrianoE-Dgz): Estado: marcar una tarea como completada o pendiente, actualizando la base de datos.
// TODO(AdrianoE-Dgz): AdrianoE-Dgzminación: borrar una tarea utilizando su identificador; no debe reaparecer al reiniciar.
// TODO(AdrianoE-Dgz): Sin conexión: todas las operaciones deben funcionar sin un servidor ni solicitudes HTTP.
// TODO(AdrianoE-Dgz): Multiplataforma: diseñar la persistencia para Android, iOS, Windows, Linux, macOS y navegador, con el mismo proyecto Flutter.
// TODO(AdrianoE-Dgz): Calidad: manejar errores de almacenamiento, liberar recursos cuando corresponda y evitar consultas a la base de datos dentro de build().

@DriftDatabase(tables: [TareaTabla])
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

// Lazy loading
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app.db'));

    return NativeDatabase(file);
  });
}