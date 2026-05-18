class HabitModel {
  final String userId;
  final String fecha;   // "2026-05-17" — clave del día
  final double horasSuenio;
  final int cafes;
  final double aguaLitros;
  final int animo;      // 1-5
  

  HabitModel({
    required this.userId,
    required this.fecha,
    required this.horasSuenio,
    required this.cafes,
    required this.aguaLitros,
    required this.animo,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'fecha': fecha,
      'horasSuenio': horasSuenio,
      'cafes': cafes,
      'aguaLitros': aguaLitros,
      'animo': animo,
    };
  }

  factory HabitModel.fromMap(Map<String, dynamic> map) {
    return HabitModel(
      userId: map['userId'],
      fecha: map['fecha'],
      horasSuenio: map['horasSuenio'] ?? 0.0,
      cafes: map['cafes'] ?? 0,
      aguaLitros: map['aguaLitros'] ?? 0.0,
      animo: map['animo'] ?? 0,
    );
  }
}