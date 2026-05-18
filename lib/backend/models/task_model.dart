class TaskModel {
  final String? id;
  final String userId;
  final String title;
  final String subject;
  final int estimatedMins;
  final int importance;
  final String type;
  final int xpReward;
  final DateTime createdAt;

  TaskModel({
    this.id,
    required this.userId,
    required this.title,
    required this.subject,
    required this.estimatedMins,
    required this.importance,
    required this.type,
    required this.xpReward,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'subject': subject,
      'estimatedMins': estimatedMins,
      'importance': importance,
      'type': type,
      'xpReward': xpReward,
      'createdAt': createdAt,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      userId: map['userId'],
      title: map['title'],
      subject: map['subject'],
      estimatedMins: map['estimatedMins'],
      importance: map['importance'],
      type: map['type'],
      xpReward: map['xpReward'],
      createdAt: map['createdAt'],
    );
  }
}