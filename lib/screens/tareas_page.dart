import 'package:material_ui/material_ui.dart';
import 'package:gestor_tareas_local/data/sqlite_handler.dart';

// Pantalla base SIN persistencia ni operaciones CRUD implementadas.
// Conserva las indicaciones todo para orientar tu trabajo. Todos los todo que están en este archivo los creé yo.
class TareasPage extends StatefulWidget {
  const TareasPage({super.key});

  @override
  State<TareasPage> createState() => _TareasPageState();
}

class _TareasPageState extends State<TareasPage> {
  final TextEditingController _tituloController = TextEditingController();
  TextEditingController? _editarTituloController;

  late AppDatabase database;
  late List<TareaTablaData> _tareas = [];
  bool cargando = true;
  bool editando = false;
  TareaTablaData? tareaEditando;

  @override
  void initState() {
    super.initState();
    // Inicializa la base de datos
    database = AppDatabase();
    cargarTareas();
  }

  // Carga la lista de tareas
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

  // DONE(AdrianoE-Dgz): Implementar Actualización de Tarea
  void _alternarCompletada(TareaTablaData tarea, bool completada) async {
    TareaTablaData newTarea = TareaTablaData(id: tarea.id, titulo: tarea.titulo, completada: completada);

    bool actualizada = await database.actualizarTarea(newTarea);

    if(!actualizada) {
      _pendiente('Error al actualizar tarea ${tarea.titulo}');
    } else {
      _pendiente('${tarea.titulo} actualizada a ${completada ? "Completada" : "Sin Completar"}');
    }

    cargarTareas();
  }

  // DONEAdrianoE-Dgz): Implementar Edición de Tarea
  void _mostrarEditar(TareaTablaData tarea) {
    setState(() {
      _editarTituloController = TextEditingController();
      editando = true;
      tareaEditando = tarea;
      _editarTituloController!.text = tarea.titulo;
    });
  }

  void _editarTarea() async {
    String titulo = _editarTituloController!.text.trim();

    if(titulo.isEmpty) {
      _pendiente('Error al actualizar tarea "${tareaEditando!.titulo}"');
    }

    TareaTablaData newTarea = TareaTablaData(id: tareaEditando!.id, titulo: titulo, completada: tareaEditando!.completada);

    bool actualizada = await database.actualizarTarea(newTarea);

    if(!actualizada) {
      _pendiente('Error al actualizar tarea ${tareaEditando!.titulo}');
    } else {
      _pendiente('"${tareaEditando!.titulo}" actualizada a "$titulo"');
    }

    setState(() {
      _editarTituloController!.dispose();
      editando = false;
      tareaEditando = null;
    });

    cargarTareas();
  }

  // DONE(AdrianoE-Dgz): Implementar Eliminación de Tarea
  void _eliminarTarea(TareaTablaData tarea) async {
    int idEliminar = tarea.id;

    int estado = await database.eliminarTarea(idEliminar);

    if(estado != 1){
      _pendiente('Error al eliminar Tarea: ${tarea.titulo}');
    } else {
      _pendiente('Tarea "${tarea.titulo}" eliminada');
    }
    
    cargarTareas();
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
                  ? Center(child: Text('Todavía no hay tareas guardadas'))
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
                                  onPressed: () => _mostrarEditar(tarea),
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
            editando ? 
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    controller: _editarTituloController,
                    decoration: const InputDecoration(
                      labelText: 'Editar nombre',
                      border: OutlineInputBorder(),
                    )
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 5.0,
                    children: [
                    FilledButton.icon(
                      onPressed: _editarTarea,
                      icon: const Icon(Icons.add),
                      label: const Text('Editar tarea'),
                    ),
                    FilledButton.icon(
                      onPressed: () => setState(() {
                        editando = false;
                        _editarTituloController!.dispose();
                        tareaEditando = null;
                      }),
                      icon: const Icon(Icons.cancel),
                      label: const Text('Cancelar'),
                    ),
                  ],)
                ],
              )
            : const SizedBox(height: 0)
          ],
        ),
      ),
    );
  }
}

 