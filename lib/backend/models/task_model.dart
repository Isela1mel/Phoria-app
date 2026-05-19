import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String? id;
  final String titulo;
  final String dificultad; // 'facil', 'medio', 'dificil'
  final int xpReward; // se calcula según dificultad
  final bool completada;
  final String userId;
  final DateTime fecha;

  TaskModel({
    this.id,
    required this.titulo,
    required this.dificultad,
    required this.xpReward,
    required this.completada,
    required this.userId,
    required this.fecha,
  });

  // ───────── XP según dificultad ─────────
  static int xpPorDificultad(String d) {
    switch (d) {
      case 'dificil':
        return 150;
      case 'medio':
        return 100;
      case 'facil':
        return 50;
      default:
        return 50;
    }
  }

  // ───────── Convertir a Map ─────────
  Map<String, dynamic> toMap() => {
    'titulo': titulo,
    'dificultad': dificultad,
    'xpReward': xpReward,
    'completada': completada,
    'userId': userId,
    'fecha': fecha.toIso8601String(),
    'creadaEn': FieldValue.serverTimestamp(),
  };

  // ───────── Crear desde Firestore ─────────
  factory TaskModel.fromDoc(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return TaskModel(
      id: doc.id,
      titulo: d['titulo'],
      dificultad: d['dificultad'],
      xpReward: d['xpReward'],
      completada: d['completada'],
      userId: d['userId'],
      fecha: DateTime.parse(d['fecha']),
    );
  }
}
