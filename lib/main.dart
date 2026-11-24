import 'package:catppuccin_flutter/catppuccin_flutter.dart';
import 'package:gestor_tareas_local/data/sqlite_handler.dart';
import 'package:material_ui/material_ui.dart';
import 'screens/tareas_page.dart';
import 'theme.dart';

late AppDatabase database;

void main() {
  runApp(const GestorTareasApp());
}

/// Punto de entrada de la aplicación.
/// La configuración del almacenamiento se agregará como parte de la tarea.
class GestorTareasApp extends StatelessWidget {
  const GestorTareasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestor de tareas',
      debugShowCheckedModeBanner: false,
      theme: catppuccinTheme(catppuccin.frappe),
      home: const TareasPage(),
    );
  }
}
