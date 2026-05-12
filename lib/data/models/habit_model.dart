class HabitModel {
  final String userId;
  final String title;
  final int streak;
  final bool completedToday;

  HabitModel({
    required this.userId,
    required this.title,
    required this.streak,
    required this.completedToday,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'streak': streak,
      'completedToday': completedToday,
    };
  }

  factory HabitModel.fromMap(Map<String, dynamic> map) {
    return HabitModel(
      userId: map['userId'],
      title: map['title'],
      streak: map['streak'],
      completedToday: map['completedToday'],
    );
  }
}