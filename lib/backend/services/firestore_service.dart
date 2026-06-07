import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';
import '../models/task_model.dart';
import '../models/block_model.dart';
import '../models/session_model.dart';
import '../models/schedule_model.dart';
import '../models/habit_model.dart';
import '../models/blocked_app_model.dart';
import '../models/weekly_report_model.dart';
import '../models/voice_note_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;


  // USERS
  Future<void> createUser(String uid, UserModel user) async {
    await _db.collection('users').doc(uid).set(user.toMap());
  }

  Future<UserModel?> getUser(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data()!);
    }
    return null;
  }

  // SCHEDULES
  Future<void> createSchedule(String uid, ScheduleModel schedule) async {
    await _db.collection('schedules').doc(uid).set(schedule.toMap());
  }

  // TASKS
  Future<void> createTask(TaskModel task) async {
    await _db.collection('tasks').add(task.toMap());
  }

  Future<List<TaskModel>> getTasks(String userId) async {
    final snapshot = await _db
        .collection('tasks')
        .where('userId', isEqualTo: userId)
        .get();

    return snapshot.docs
        .map((doc) => TaskModel.fromMap(doc.data()))
        .toList();
  }

  // BLOCKS
  Future<void> createBlock(BlockModel block) async {
    await _db.collection('blocks').add(block.toMap());
  }

  // SESSIONS
  Future<void> createSession(SessionModel session) async {
    await _db.collection('sessions').add(session.toMap());
  }

  // HABITS
  Future<void> createHabit(HabitModel habit) async {
    await _db.collection('habits').add(habit.toMap());
  }

  // BLOCKED APPS
  Future<void> createBlockedApp(BlockedAppModel app) async {
    await _db.collection('blocked_apps').add(app.toMap());
  }

  // WEEKLY REPORTS
  Future<void> createWeeklyReport(WeeklyReportModel report) async {
    await _db.collection('weekly_reports').add(report.toMap());
  }

  // VOICE NOTES
  Future<void> createVoiceNote(VoiceNoteModel note) async {
    await _db.collection('voice_notes').add(note.toMap());
  }
}