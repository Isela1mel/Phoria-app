import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_scheduel.dart';
import '../models/user_model.dart';
import '../models/activity_block_model.dart';

class UserService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  /// Guarda o actualiza el horario del usuario
  /// Se guarda con ID = userId para fácil acceso
  Future<UserSchedule> guardarHorario(UserSchedule horario) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('Usuario no autenticado');

    await _db.collection('schedules').doc(uid).set(horario.toMap());
    return horario;
  }

  /// Lee el horario del usuario actual
  Future<UserSchedule?> leerHorario() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return null;

    final doc = await _db.collection('schedules').doc(uid).get();
    return doc.exists ? UserSchedule.fromMap(doc.data()!) : null;
  }

  /// Lee el horario de un usuario específico
  Future<UserSchedule?> leerHorarioPorUserId(String userId) async {
    final doc = await _db.collection('schedules').doc(userId).get();
    return doc.exists ? UserSchedule.fromMap(doc.data()!) : null;
  }

  /// Actualiza un campo específico del horario
  Future<void> actualizarCampoHorario(String campo, dynamic valor) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('Usuario no autenticado');

    await _db.collection('schedules').doc(uid).update({
      campo: valor,
    });
  }

  /// Elimina el horario del usuario
  Future<void> eliminarHorario() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('Usuario no autenticado');

    await _db.collection('schedules').doc(uid).delete();
  }

  /// Guarda o actualiza los datos del usuario
  Future<UserModel> guardarUsuario(UserModel usuario) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('Usuario no autenticado');

    await _db.collection('users').doc(uid).set(usuario.toMap());
    return usuario;
  }

  /// Lee los datos del usuario actual
  Future<UserModel?> leerUsuario() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return null;

    final doc = await _db.collection('users').doc(uid).get();
    return doc.exists ? UserModel.fromMap(doc.data()!) : null;
  }

  /// Actualiza un campo del usuario
  Future<void> actualizarCampoUsuario(String campo, dynamic valor) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('Usuario no autenticado');

    await _db.collection('users').doc(uid).update({
      campo: valor,
    });
  }

  /// Incrementa el XP del usuario
  Future<void> agregarXP(int cantidad) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('Usuario no autenticado');

    await _db.collection('users').doc(uid).update({
      'xp': FieldValue.increment(cantidad),
    });
  }

  /// Incrementa el streak del usuario
  Future<void> incrementarStreak() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('Usuario no autenticado');

    await _db.collection('users').doc(uid).update({
      'streak': FieldValue.increment(1),
    });
  }

  // ==================== MÉTODOS PARA ACTIVITY_BLOCKS ====================

  /// Guarda una actividad en la colección del usuario
  /// Se guarda en: usuarios/{uid}/activity_blocks/{docId}
  Future<String> guardarActividad(ActivityBlockModel actividad) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('Usuario no autenticado');

    // Reemplazar userId con el del usuario autenticado
    final actividadConUserId = actividad.copyWith(userId: uid);

    final docRef = await _db
        .collection('usuarios')
        .doc(uid)
        .collection('activity_blocks')
        .add(actividadConUserId.toMap());

    return docRef.id;
  }

  /// Guarda múltiples actividades (batch operation) SIN duplicar:
  /// Antes: solo agregaba nuevas, causando duplicados.
  /// Ahora: elimina todas las actividades anteriores y guarda solo las nuevas.
  Future<List<String>> guardarMultiplesActividades(List<ActivityBlockModel> actividades) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('Usuario no autenticado');

    // Eliminar todas las actividades anteriores
    final snapshot = await _db
        .collection('usuarios')
        .doc(uid)
        .collection('activity_blocks')
        .get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }

    // Guardar las nuevas actividades
    final ids = <String>[];
    for (var actividad in actividades) {
      final id = await guardarActividad(actividad);
      ids.add(id);
    }
    return ids;
  }

  /// Lee todas las actividades del usuario actual
  Future<List<ActivityBlockModel>> leerActividades() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return [];

    final snapshot = await _db
        .collection('usuarios')
        .doc(uid)
        .collection('activity_blocks')
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => ActivityBlockModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  /// Lee las actividades de un usuario específico
  Future<List<ActivityBlockModel>> leerActividadesPorUserId(String userId) async {
    final snapshot = await _db
        .collection('usuarios')
        .doc(userId)
        .collection('activity_blocks')
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => ActivityBlockModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  /// Lee una actividad específica
  Future<ActivityBlockModel?> leerActividad(String actividadId) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return null;

    final doc = await _db
        .collection('usuarios')
        .doc(uid)
        .collection('activity_blocks')
        .doc(actividadId)
        .get();

    return doc.exists
        ? ActivityBlockModel.fromMap(doc.data()!, doc.id)
        : null;
  }

  /// Actualiza una actividad
  Future<void> actualizarActividad(
      String actividadId, ActivityBlockModel actividad) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('Usuario no autenticado');

    await _db
        .collection('usuarios')
        .doc(uid)
        .collection('activity_blocks')
        .doc(actividadId)
        .update(actividad.toMap());
  }

  /// Elimina una actividad
  Future<void> eliminarActividad(String actividadId) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('Usuario no autenticado');

    await _db
        .collection('usuarios')
        .doc(uid)
        .collection('activity_blocks')
        .doc(actividadId)
        .delete();
  }

  /// Elimina TODAS las actividades del usuario
  Future<void> eliminarTodasLasActividades() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('Usuario no autenticado');

    final snapshot = await _db
        .collection('usuarios')
        .doc(uid)
        .collection('activity_blocks')
        .get();

    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  /// Obtiene el usuario actual
  User? get usuarioActual => _auth.currentUser;

  /// Cierra sesión
  Future<void> cerrarSesion() async {
    await _auth.signOut();
  }
}