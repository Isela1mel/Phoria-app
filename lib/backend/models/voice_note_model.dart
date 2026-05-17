import 'package:cloud_firestore/cloud_firestore.dart';

class VoiceNoteModel {
  final String userId;
  final String audioUrl; // ruta o URL del audio
  final int duration; // en segundos
  final String? transcript; // opcional (texto)
  final Timestamp createdAt;

  VoiceNoteModel({
    required this.userId,
    required this.audioUrl,
    required this.duration,
    this.transcript,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'audioUrl': audioUrl,
      'duration': duration,
      'transcript': transcript,
      'createdAt': createdAt,
    };
  }

  factory VoiceNoteModel.fromMap(Map<String, dynamic> map) {
    return VoiceNoteModel(
      userId: map['userId'],
      audioUrl: map['audioUrl'],
      duration: map['duration'],
      transcript: map['transcript'],
      createdAt: map['createdAt'],
    );
  }
}