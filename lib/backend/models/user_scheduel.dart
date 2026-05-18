import 'package:cloud_firestore/cloud_firestore.dart';

/// Modelo para horario fijo del usuario (bloques definidos: escuela, clases extras, etc)
/// NO tiene horaInicio/Fin porque son bloques repetitivos diarios
class UserSchedule {
  final String? id;           
  final String userId;
  final String entradaClases;  // Formato: "HH:MM" (ej: "07:00")
  final String salidaClases;   // Formato: "HH:MM" (ej: "14:00")
  final int traslado;         // Minutos de traslado
  final int suenioMinimo;     // Horas mínimas de sueño
  final String? horaLevantarse;   // Formato: "HH:MM" (ej: "06:00")
  final Timestamp? createdAt;

  UserSchedule({
    this.id,
    required this.userId,
    required this.entradaClases,
    required this.salidaClases,
    required this.traslado,
    required this.suenioMinimo,
    this.horaLevantarse,
    this.createdAt,
  });

  Map<String, dynamic> toMap() => {
    'userId': userId,
    'entradaClases': entradaClases,
    'salidaClases': salidaClases,
    'traslado': traslado,
    'suenioMinimo': suenioMinimo,
    'horaLevantarse': horaLevantarse,
    'createdAt': createdAt ?? Timestamp.now(),
  };

  factory UserSchedule.fromMap(Map<String, dynamic> map) =>
    UserSchedule(
      userId: map['userId'],
      entradaClases: map['entradaClases'],
      salidaClases: map['salidaClases'],
      traslado: map['traslado'],
      suenioMinimo: map['suenioMinimo'],
      horaLevantarse: map['horaLevantarse'],
      createdAt: map['createdAt'],
    );
}