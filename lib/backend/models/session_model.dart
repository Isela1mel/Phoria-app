import 'package:cloud_firestore/cloud_firestore.dart';

class SessionModel {
  final String? id;
  final String userId;
  final String blockId;
  final int duration;
  final String type;
  final bool exitoso;
  final Timestamp timestamp;

  SessionModel({
    this.id,
    required this.userId,
    required this.blockId,
    required this.duration,
    required this.type,
    required this.exitoso,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'blockId': blockId,
      'duration': duration,
      'type': type,
      'exitoso': exitoso,
      'timestamp': timestamp,
    };
  }

  factory SessionModel.fromMap(Map<String, dynamic> map) {
    return SessionModel(
      id: map['id'],
      userId: map['userId'],
      blockId: map['blockId'],
      duration: map['duration'],
      type: map['type'],
      exitoso: map['exitoso'],
      timestamp: map['timestamp'],
    );
  }
}