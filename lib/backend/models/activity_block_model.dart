import 'package:cloud_firestore/cloud_firestore.dart';

/// Modelo para actividades con horario específico (Estudiar Java 15:30-17:00)
class ActivityBlockModel {
  final String? id;
  final String userId;
  final String nombre;
  final String horaInicio;  // Formato: "HH:MM"
  final String horaFin;     // Formato: "HH:MM"
  final Timestamp createdAt;

  ActivityBlockModel({
    this.id,
    required this.userId,
    required this.nombre,
    required this.horaInicio,
    required this.horaFin,
    required this.createdAt,
  });

  /// Convierte a Map para guardar en Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'nombre': nombre,
      'horaInicio': horaInicio,
      'horaFin': horaFin,
      'createdAt': createdAt,
    };
  }

  /// Crea instancia desde documento de Firestore
  factory ActivityBlockModel.fromMap(Map<String, dynamic> map, String docId) {
    return ActivityBlockModel(
      id: docId,
      userId: map['userId'] ?? '',
      nombre: map['nombre'] ?? '',
      horaInicio: map['horaInicio'] ?? '',
      horaFin: map['horaFin'] ?? '',
      createdAt: map['createdAt'] ?? Timestamp.now(),
    );
  }

  /// Copia con cambios opcionales
  ActivityBlockModel copyWith({
    String? id,
    String? userId,
    String? nombre,
    String? horaInicio,
    String? horaFin,
    Timestamp? createdAt,
  }) {
    return ActivityBlockModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      nombre: nombre ?? this.nombre,
      horaInicio: horaInicio ?? this.horaInicio,
      horaFin: horaFin ?? this.horaFin,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
