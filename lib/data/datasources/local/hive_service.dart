import 'package:hive_flutter/hive_flutter.dart';

import '../../models/user_model.dart';
import '../../models/task_model.dart';
import '../../models/session_model.dart';
import '../../models/blocked_app_model.dart';

class HiveService {

  static Future<void> init() async {

    await Hive.initFlutter();

    // REGISTER ADAPTERS
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(TaskModelAdapter());
    Hive.registerAdapter(SessionModelAdapter());
    Hive.registerAdapter(BlockedAppModelAdapter());

    // OPEN BOXES
    await Hive.openBox<UserModel>('userBox');
    await Hive.openBox<TaskModel>('taskBox');
    await Hive.openBox<SessionModel>('sessionBox');
    await Hive.openBox<BlockedAppModel>('blockedAppBox');
  }
}