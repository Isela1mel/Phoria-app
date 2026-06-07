import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
part 'session_model.g.dart';

@HiveType(typeId: 2)
class SessionModel extends HiveObject {

  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String blockId;

  @HiveField(2)
  final int duration;

  @HiveField(3)
  final String type;

  @HiveField(4)
  final bool metodoExitoso;

  @HiveField(5)
  final Timestamp timestamp;

  SessionModel({
    required this.userId,
    required this.blockId,
    required this.duration,
    required this.type,
    required this.metodoExitoso,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'blockId': blockId,
      'duration': duration,
      'type': type,
      'metodoExitoso': metodoExitoso,
      'timestamp': timestamp,
    };
  }

  factory SessionModel.fromMap(Map<String, dynamic> map) {
    return SessionModel(
      userId: map['userId'],
      blockId: map['blockId'],
      duration: map['duration'],
      type: map['type'],
      metodoExitoso: map['metodoExitoso'],
      timestamp: map['timestamp'],
    );
  }
}