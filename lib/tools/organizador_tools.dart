import '../backend/models/task_model.dart';
import '../backend/models/block_model.dart';

class Tools {
  /// Organiza las tareas pendientes en los espacios libres de los bloques.
  ///
  /// 1. Lee bloques y tareas existentes.
  /// 2. Detecta espacios libres.
  /// 3. Calcula prioridad de tareas.
  /// 4. Ordena e inserta tareas en los huecos.
  /// 5. Reacomoda tareas menos importantes si es necesario.
  static List<OrganizedTask> organizarTareas({
    required List<BlockModel> bloques,
    required List<TaskModel> tareasPendientes,
  }) {
    // 1. Detectar espacios libres en los bloques
    final espaciosLibres = _detectarEspaciosLibres(bloques);

    // 2. Calcular prioridad de cada tarea
    final tareasConPrioridad = tareasPendientes.map((t) => _TareaConPrioridad(
      tarea: t,
      prioridad: _calcularPrioridad(t),
    )).toList();
    tareasConPrioridad.sort((a, b) => b.prioridad.compareTo(a.prioridad));

    // 3. Asignar tareas a espacios libres
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

    // 4. Las tareas que no caben se pueden reprogramar para otro día
    // (esto se puede mejorar para desplazar tareas menos prioritarias)
    // ...

    return resultado;
  }

  /// Detecta los espacios libres entre bloques existentes.
  static List<_EspacioLibre> _detectarEspaciosLibres(List<BlockModel> bloques) {
    // Ordenar bloques por inicio
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
    // Espacio antes del primer bloque y después del último
    // (opcional, según reglas de negocio)
    return espacios;
  }

  /// Calcula la prioridad de una tarea según fecha límite, dificultad y duración.
  static int _calcularPrioridad(TaskModel tarea) {
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
    // Entre menos días, más prioridad
    base += (diasRestantes <= 0) ? 1000 : (100 - diasRestantes * 5).clamp(0, 100);
    // Se puede agregar duración si está disponible
    return base;
  }
}

/// Representa una tarea organizada en un bloque o espacio libre.
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
