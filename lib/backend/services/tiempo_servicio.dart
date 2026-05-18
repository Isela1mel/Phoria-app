  
/// Servicio para cálculos de tiempo relacionados con el día del usuario
class TimeService {
  /// Calcula los minutos libres en el día
  /// [wakeUpMinutes]: hora de despertar en minutos desde medianoche (0-1439)
  /// [sleepMinutes]: hora de dormir en minutos desde medianoche (0-1439), puede ser menor que wakeUpMinutes si cruza medianoche
  /// [fixedActivities]: lista de duraciones de actividades fijas en minutos
  /// Retorna los minutos disponibles en el día
  int calcularTiempoLibre({
    required int wakeUpMinutes,
    required int sleepMinutes,
    required List<int> fixedActivities,
  }) {
    const int totalDia = 1440; // Total de minutos en un día

    // Calcular duración del sueño
    // Si sleepMinutes <= wakeUpMinutes, el sueño cruza medianoche
    int duracionSueno;
    if (sleepMinutes > wakeUpMinutes) {
      duracionSueno = sleepMinutes - wakeUpMinutes;
    } else {
      duracionSueno = (1440 - wakeUpMinutes) + sleepMinutes;
    }

    // Sumar todas las actividades fijas
    int totalActividadesFijas = fixedActivities.fold(0, (a, b) => a + b);

    // Calcular minutos libres
    int minutosLibres = totalDia - duracionSueno - totalActividadesFijas;

    // Asegurar que no sea negativo
    return minutosLibres < 0 ? 0 : minutosLibres;
  }
}