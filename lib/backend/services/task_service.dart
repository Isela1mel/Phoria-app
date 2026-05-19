import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/task_model.dart';
import 'xp_service.dart';

class TaskService {
    /// Obtiene todas las tareas pendientes del usuario actual
    Future<List<TaskModel>> obtenerTareasPendientes() async {
      final snap = await _db
          .collection('tasks')
          .where('userId', isEqualTo: uid)
          .where('completada', isEqualTo: false)
          .get();
      return snap.docs.map(TaskModel.fromDoc).toList();
    }
  final _db = FirebaseFirestore.instance;
  String get uid => FirebaseAuth.instance.currentUser!.uid;

  // ── CREAR tarea nueva
  Future<void> crearTarea(TaskModel tarea) async {
    await _db.collection('tasks').add(tarea.toMap());
  }

  // ── LEER tareas en tiempo real (Stream)
  // Usa esto en la pantalla con StreamBuilder
  Stream<List<TaskModel>> tareasStream() {
    return _db
      .collection('tasks')
      .where('userId', isEqualTo: uid)
      .where('completada', isEqualTo: false)
      .snapshots()
      .map((snap) => snap.docs.map(TaskModel.fromDoc).toList());
  }

  // ── LEER tareas completadas en tiempo real
  Stream<List<TaskModel>> tareasCompletadasStream() {
    return _db
      .collection('tasks')
      .where('userId', isEqualTo: uid)
      .where('completada', isEqualTo: true)
      .snapshots()
      .map((snap) => snap.docs.map(TaskModel.fromDoc).toList());
  }

  // ── COMPLETAR tarea y dar XP automáticamente
  Future<void> completarTarea(TaskModel tarea) async {
    // 1. Marcar como completada en Firestore
    await _db.collection('tasks').doc(tarea.id).update({
      'completada': true,
      'completadaEn': FieldValue.serverTimestamp(),
    });
    // 2. Sumar XP al usuario automáticamente
    await XpService().sumarXp(tarea.xpReward);
  }

  // ── ELIMINAR tarea
  Future<void> eliminarTarea(String taskId) async {
    await _db.collection('tasks').doc(taskId).delete();
  }
}