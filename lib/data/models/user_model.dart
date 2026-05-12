import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final int level;

  @HiveField(3)
  final int xp;

  @HiveField(4)
  final int streak;

  @HiveField(5)
  final String characterClass;

  @HiveField(6)
  final Timestamp createdAt;

  UserModel({
    required this.name,
    required this.email,
    required this.level,
    required this.xp,
    required this.streak,
    required this.characterClass,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'level': level,
      'xp': xp,
      'streak': streak,
      'characterClass': characterClass,
      'createdAt': createdAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      email: map['email'],
      level: map['level'],
      xp: map['xp'],
      streak: map['streak'],
      characterClass: map['characterClass'],
      createdAt: map['createdAt'],
    );
  }
}