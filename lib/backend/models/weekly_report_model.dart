class WeeklyReportModel {
  final String userId;
  final int totalFocusTime;
  final int totalXP;
  final int tasksCompleted;

  WeeklyReportModel({
    required this.userId,
    required this.totalFocusTime,
    required this.totalXP,
    required this.tasksCompleted,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'totalFocusTime': totalFocusTime,
      'totalXP': totalXP,
      'tasksCompleted': tasksCompleted,
    };
  }

  factory WeeklyReportModel.fromMap(Map<String, dynamic> map) {
    return WeeklyReportModel(
      userId: map['userId'],
      totalFocusTime: map['totalFocusTime'],
      totalXP: map['totalXP'],
      tasksCompleted: map['tasksCompleted'],
    );
  }
}