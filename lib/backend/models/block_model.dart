import 'package:cloud_firestore/cloud_firestore.dart';

class BlockModel {
  final String? id;
  final String userId;
  final String taskId;
  final String metodo;
  final DateTime iniciadoEn;
  final DateTime? terminadoEn;
  final bool cancelado;
  final int xpGanado;

  BlockModel({
    this.id,
    required this.userId,
    required this.taskId,
    required this.metodo,
    required this.iniciadoEn,
    this.terminadoEn,
    required this.cancelado,
    required this.xpGanado,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'taskId': taskId,
      'metodo': metodo,
      'iniciadoEn': iniciadoEn,
      'terminadoEn': terminadoEn,
      'cancelado': cancelado,
      'xpGanado': xpGanado,
    };
  }

  factory BlockModel.fromMap(Map<String, dynamic> map) {
    return BlockModel(
      id: map['id'],
      userId: map['userId'],
      taskId: map['taskId'],
      metodo: map['metodo'],
      iniciadoEn: (map['iniciadoEn'] as Timestamp).toDate(),
      terminadoEn: map['terminadoEn'] != null ? (map['terminadoEn'] as Timestamp).toDate() : null,
      cancelado: map['cancelado'] ?? false,
      xpGanado: map['xpGanado'] ?? 0,
    );
  }
}