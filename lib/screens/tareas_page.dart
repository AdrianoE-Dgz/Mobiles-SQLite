import 'package:material_ui/material_ui.dart';
import 'package:gestor_tareas_local/data/sqlite_handler.dart';

// Pantalla base SIN persistencia ni operaciones CRUD implementadas.
// Conserva las indicaciones TODO para orientar tu trabajo.
class TareasPage extends StatefulWidget {
  const TareasPage({super.key});

  @override
  State<TareasPage> createState() => _TareasPageState();
}

class _TareasPageState extends State<TareasPage> {
  final TextEditingController _tituloController = TextEditingController();

  late AppDatabase database;
  late List<TareaTablaData> _tareas = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    // Inicializa la base de datos
    database = AppDatabase();
    cargarTareas();
  }

  Future<void> cargarTareas () async {
    setState(() {
      cargando = true;
    });

    try{
      _tareas = await database.getAllTareas();
    } catch (e) {
      _pendiente(e.toString());
    }

    if(mounted) {
      setState(() {
        cargando = false;
      });
    }
  }

  // DONE(AdrianoE-Dgz): Implementar Registro de Tarea
  void _agregarTarea() async {
    String titulo = _tituloController.text.trim();
    TareaTablaCompanion tarea = TareaTablaCompanion.insert(titulo: titulo, completada: false);
    
    int estado = await database.insertarTarea(tarea);

    if(estado == -1){
      _pendiente("Error al crear tarea");
    }

    cargarTareas();
  }

  // TODO(AdrianoE-Dgz): Implementar Actualización de Tarea
  void _alternarCompletada(TareaTablaData tarea, bool completada) {
    _pendiente('Implementar actualización de tarea');
  }

  // TODO(AdrianoE-Dgz): Implementar Edición de Tarea
  void _editarTarea(TareaTablaData tarea) {
    _pendiente('Implementar edición de título');
  }

  // TODO(AdrianoE-Dgz): Implementar Eliminación de Tarea
  void _eliminarTarea(TareaTablaData tarea) {
    _pendiente('Implementar eliminación de tarea');
  }

  void _pendiente(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje)),
    );
  }

  @override
  void dispose() {
    _tituloController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestor de tareas')),
      body: cargando
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(
                labelText: 'Nueva tarea',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _agregarTarea,
              icon: const Icon(Icons.add),
              label: const Text('Agregar tarea'),
            ),
            const SizedBox(height: 12),
            const Text('Mis tareas', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Expanded(
              child: _tareas.isEmpty
                  ? Center(child: Text('Todavía no hay tareas guardadas $_tareas'))
                  : ListView.builder(
                      itemCount: _tareas.length,
                      itemBuilder: (context, index) {
                        final tarea = _tareas[index];
                        return Card(
                          child: ListTile(
                            leading: Checkbox(
                              value: tarea.completada,
                              onChanged: (valor) {
                                if (valor != null) {
                                  _alternarCompletada(tarea, valor);
                                }
                              },
                            ),
                            title: Text(tarea.titulo),
                            subtitle: Text('ID: ${tarea.id}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  tooltip: 'Editar',
                                  icon: const Icon(Icons.edit),
                                  onPressed: () => _editarTarea(tarea),
                                ),
                                IconButton(
                                  tooltip: 'Eliminar',
                                  icon: const Icon(Icons.delete_outline),
                                  onPressed: () => _eliminarTarea(tarea),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
