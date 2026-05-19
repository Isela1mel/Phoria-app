/// Motor centralizado para organizar tareas automáticamente en bloques libres.
///
/// Este archivo contiene toda la lógica de organización, prioridad y acomodo.
/// Solo depende de los servicios y modelos existentes.

import 'task_service.dart';
import 'block_service.dart';
import '../models/task_model.dart';
import '../models/block_model.dart';

class ToListOrganizer {
  final TaskService _taskService;
  final BlockService _blockService;

  ToListOrganizer({
    TaskService? taskService,
    BlockService? blockService,
  })  : _taskService = taskService ?? TaskService(),
        _blockService = blockService ?? BlockService();

  /// Organiza tareas pendientes en los espacios libres de los bloques.
  /// Devuelve una lista de sugerencias de acomodo.
  Future<List<OrganizedTask>> organizarTareas() async {
    // 1. Obtener bloques existentes desde la BD
    final bloques = await _obtenerBloquesUsuario();
    // 2. Obtener tareas pendientes desde la BD
    final tareas = await _obtenerTareasPendientes();
    // 3. Organizar tareas en espacios libres
    return _organizarTareas(bloques: bloques, tareasPendientes: tareas);
  }

  Future<List<BlockModel>> _obtenerBloquesUsuario() async {
    final uid = _taskService.uid;
    final hoy = DateTime.now();
    return await _blockService.obtenerBloquesUsuario(uid, dia: hoy);
  }

  Future<List<TaskModel>> _obtenerTareasPendientes() async {
    return await _taskService.obtenerTareasPendientes();
  }

  /// Lógica principal de organización (antes estaba en tools/)
  List<OrganizedTask> _organizarTareas({
    required List<BlockModel> bloques,
    required List<TaskModel> tareasPendientes,
  }) {
    final espaciosLibres = _detectarEspaciosLibres(bloques);
    final tareasConPrioridad = tareasPendientes.map((t) => _TareaConPrioridad(
      tarea: t,
      prioridad: _calcularPrioridad(t),
    )).toList();
    tareasConPrioridad.sort((a, b) => b.prioridad.compareTo(a.prioridad));
    final resultado = <OrganizedTask>[];
    final tareasPendientesAsignar = List<_TareaConPrioridad>.from(tareasConPrioridad);
    for (final espacio in espaciosLibres) {
      if (tareasPendientesAsignar.isEmpty) break;
      final tarea = tareasPendientesAsignar.removeAt(0);
      resultado.add(OrganizedTask(
        tarea: tarea.tarea,
        bloqueId: espacio.bloqueId,
        inicio: espacio.inicio,
        fin: espacio.fin,
      ));
    }
    // Las tareas que no caben se pueden reprogramar para otro día
    return resultado;
  }

  List<_EspacioLibre> _detectarEspaciosLibres(List<BlockModel> bloques) {
    final ordenados = List<BlockModel>.from(bloques)
      ..sort((a, b) => a.iniciadoEn.compareTo(b.iniciadoEn));
    final espacios = <_EspacioLibre>[];
    for (int i = 0; i < ordenados.length - 1; i++) {
      final finActual = ordenados[i].terminadoEn ?? ordenados[i].iniciadoEn;
      final inicioSiguiente = ordenados[i + 1].iniciadoEn;
      if (finActual.isBefore(inicioSiguiente)) {
        espacios.add(_EspacioLibre(
          bloqueId: null,
          inicio: finActual,
          fin: inicioSiguiente,
        ));
      }
    }
    return espacios;
  }

  int _calcularPrioridad(TaskModel tarea) {
    final ahora = DateTime.now();
    final diasRestantes = tarea.fecha.difference(ahora).inDays;
    int base = 0;
    switch (tarea.dificultad) {
      case 'dificil':
        base += 100;
        break;
      case 'medio':
        base += 60;
        break;
      case 'facil':
        base += 30;
        break;
    }
    base += (diasRestantes <= 0) ? 1000 : (100 - diasRestantes * 5).clamp(0, 100);
    return base;
  }
}

class OrganizedTask {
  final TaskModel tarea;
  final String? bloqueId;
  final DateTime inicio;
  final DateTime fin;
  OrganizedTask({
    required this.tarea,
    required this.bloqueId,
    required this.inicio,
    required this.fin,
  });
}

class _TareaConPrioridad {
  final TaskModel tarea;
  final int prioridad;
  _TareaConPrioridad({required this.tarea, required this.prioridad});
}

class _EspacioLibre {
  final String? bloqueId;
  final DateTime inicio;
  final DateTime fin;
  _EspacioLibre({this.bloqueId, required this.inicio, required this.fin});
}
