import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String email;
  final int level;
  final int xp;
  final int streak;
  final String characterClass;
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
      xp: map['xp'] ?? 0,
      streak: map['streak'],
      characterClass: map['characterClass'],
      createdAt: map['createdAt'],
    );
  }
}