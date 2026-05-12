import 'package:hive/hive.dart';
part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel extends HiveObject {

  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String subject;

  @HiveField(3)
  final int estimatedMins;

  @HiveField(4)
  final int importance;

  @HiveField(5)
  final String type;

  @HiveField(6)
  final int xpReward;

  TaskModel({
    required this.userId,
    required this.title,
    required this.subject,
    required this.estimatedMins,
    required this.importance,
    required this.type,
    required this.xpReward,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'subject': subject,
      'estimatedMins': estimatedMins,
      'importance': importance,
      'type': type,
      'xpReward': xpReward,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      userId: map['userId'],
      title: map['title'],
      subject: map['subject'],
      estimatedMins: map['estimatedMins'],
      importance: map['importance'],
      type: map['type'],
      xpReward: map['xpReward'],
    );
  }
}