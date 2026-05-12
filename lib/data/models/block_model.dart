import 'package:cloud_firestore/cloud_firestore.dart';

class BlockModel {
  final String userId;
  final String taskId;
  final String method;
  final Timestamp startedAt;
  final bool cancelled;
  final int cycles;
  final int xpEarned;

  BlockModel({
    required this.userId,
    required this.taskId,
    required this.method,
    required this.startedAt,
    required this.cancelled,
    required this.cycles,
    required this.xpEarned,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'taskId': taskId,
      'method': method,
      'startedAt': startedAt,
      'cancelled': cancelled,
      'cycles': cycles,
      'xpEarned': xpEarned,
    };
  }

  factory BlockModel.fromMap(Map<String, dynamic> map) {
    return BlockModel(
      userId: map['userId'],
      taskId: map['taskId'],
      method: map['method'],
      startedAt: map['startedAt'],
      cancelled: map['cancelled'],
      cycles: map['cycles'],
      xpEarned: map['xpEarned'],
    );
  }
}