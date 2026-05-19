import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/activity_block_model.dart';

/// Servicio para lógica de actividades en curso y stats
class ActividadService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Obtiene la actividad actual según la hora del teléfono
  Future<ActivityBlockModel?> obtenerActividadActual(String userId) async {
    final ahora = DateTime.now();
    final horaActual = _toHoraString(ahora);
    final snap = await _db
        .collection('activity_blocks')
        .where('userId', isEqualTo: userId)
        .get();
    for (final doc in snap.docs) {
      final actividad = ActivityBlockModel.fromMap(doc.data(), doc.id);
      if (_estaEnCurso(actividad, ahora)) {
        return actividad;
      }
    }
    return null;
  }

  /// Verifica si hay actividad en curso
  Future<bool> verificarActividadEnCurso(String userId) async {
    return (await obtenerActividadActual(userId)) != null;
  }

  /// Marca la actividad como completada y actualiza stats
  Future<void> completarActividad(ActivityBlockModel actividad) async {
    await _db.collection('activity_blocks').doc(actividad.id).update({
      'estado': 'completada',
    });
    // Aquí puedes llamar a otros servicios para XP, stats, nivel, etc.
    // Ejemplo:
    // await XpService().sumarXp(calcularXP(actividad.dificultad));
    // await StatsService().actualizarStats(...);
  }

  /// Marca la actividad como no completada
  Future<void> cancelarActividad(ActivityBlockModel actividad) async {
    await _db.collection('activity_blocks').doc(actividad.id).update({
      'estado': 'no_completada',
    });
    // Actualizar stats si es necesario
  }

  /// Calcula el XP según dificultad
  int calcularXP(String dificultad) {
    switch (dificultad) {
      case 'facil':
        return 20;
      case 'media':
        return 40;
      case 'dificil':
        return 80;
      default:
        return 10;
    }
  }

  /// Utilidad: verifica si la actividad está en curso
  bool _estaEnCurso(ActivityBlockModel actividad, DateTime ahora) {
    final inicio = _parseHora(actividad.horaInicio, ahora);
    final fin = _parseHora(actividad.horaFin, ahora);
    return ahora.isAfter(inicio) && ahora.isBefore(fin);
  }

  /// Convierte DateTime a string "HH:mm"
  String _toHoraString(DateTime dt) {
    return dt.hour.toString().padLeft(2, '0') + ':' + dt.minute.toString().padLeft(2, '0');
  }

  /// Parsea string "HH:mm" a DateTime del día actual
  DateTime _parseHora(String hora, DateTime base) {
    final partes = hora.split(':');
    return DateTime(base.year, base.month, base.day, int.parse(partes[0]), int.parse(partes[1]));
  }
}
