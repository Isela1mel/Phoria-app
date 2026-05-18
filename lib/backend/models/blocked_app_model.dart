class BlockedAppModel {
  final String? id;
  final String userId;
  final String appName;
  final bool isBlocked;

  BlockedAppModel({
    this.id,
    required this.userId,
    required this.appName,
    required this.isBlocked,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'appName': appName,
      'isBlocked': isBlocked,
    };
  }

  factory BlockedAppModel.fromMap(Map<String, dynamic> map) {
    return BlockedAppModel(
      id: map['id'],
      userId: map['userId'],
      appName: map['appName'],
      isBlocked: map['isBlocked'],
    );
  }
}