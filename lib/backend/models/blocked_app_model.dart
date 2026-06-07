import 'package:hive/hive.dart';
part 'blocked_app_model.g.dart';

@HiveType(typeId: 3)
class BlockedAppModel extends HiveObject {

  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String appName;

  @HiveField(2)
  final bool isBlocked;

  BlockedAppModel({
    required this.userId,
    required this.appName,
    required this.isBlocked,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'appName': appName,
      'isBlocked': isBlocked,
    };
  }

  factory BlockedAppModel.fromMap(Map<String, dynamic> map) {
    return BlockedAppModel(
      userId: map['userId'],
      appName: map['appName'],
      isBlocked: map['isBlocked'],
    );
  }
}