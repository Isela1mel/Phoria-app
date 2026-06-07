/// Scheduler: lógica de alto nivel para organizar tareas automáticamente.
/// Usa los servicios existentes para obtener datos reales de la BD.
/// No guarda ni modifica datos, solo organiza y sugiere acomodo.

import '../backend/services/task_service.dart';
import '../backend/services/block_service.dart';
import '../backend/models/task_model.dart';
import '../backend/models/block_model.dart';
import '../tools/organizador_tools.dart';

class Scheduler {
    /// Stream reactivo: organiza tareas automáticamente cada vez que cambian bloques o tareas.
    Stream<List<OrganizedTask>> streamOrganizarTareas() {
      final tareasStream = _taskService.tareasStream();

      return tareasStream.asyncMap((tareas) async {
        final bloques = await _obtenerBloquesUsuario();
        return Tools.organizarTareas(bloques: bloques, tareasPendientes: tareas);
      });
    }
  final TaskService _taskService;
  final BlockService _blockService;

  Scheduler({
    TaskService? taskService,
    BlockService? blockService,
  })  : _taskService = taskService ?? TaskService(),
        _blockService = blockService ?? BlockService();

  /// Organiza tareas pendientes en los espacios libres de los bloques.
  /// Devuelve una lista de sugerencias de acomodo.
  Future<List<OrganizedTask>> organizarTareas() async {
    final bloques = await _obtenerBloquesUsuario();
    final tareas = await _obtenerTareasPendientes();
    return Tools.organizarTareas(bloques: bloques, tareasPendientes: tareas);
  }

  /// Obtiene todos los bloques del usuario actual (puedes filtrar por día si es necesario)
  Future<List<BlockModel>> _obtenerBloquesUsuario() async {
    // Obtiene todos los bloques del usuario actual para hoy
    final uid = _taskService.uid;
    final hoy = DateTime.now();
    return await _blockService.obtenerBloquesUsuario(uid, dia: hoy);
  }

  /// Obtiene todas las tareas pendientes del usuario actual
  Future<List<TaskModel>> _obtenerTareasPendientes() async {
    return await _taskService.obtenerTareasPendientes();
  }
}
