

class ScheduleModel {
  final String userId;
  final Map<String, dynamic> days;

  ScheduleModel({
    required this.userId,
    required this.days,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'days': days,
    };
  }

  factory ScheduleModel.fromMap(Map<String, dynamic> map) {
    return ScheduleModel(
      userId: map['userId'],
      days: map['days'],
    );
  }
}