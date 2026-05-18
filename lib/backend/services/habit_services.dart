import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/habit_model.dart';

class HabitService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  /// Guarda o actualiza los hábitos de un día
  /// El ID del documento es userId_fecha para garantizar un solo registro por día
  Future<HabitModel> guardarHabitos(HabitModel habito) async {
    final docId = '${habito.userId}_${habito.fecha}';
    
    await _db.collection('habits').doc(docId).set(habito.toMap());
    return habito;
  }

  /// Lee los hábitos del día actual
  Future<HabitModel?> leerHoy() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return null;
    
    final hoy = DateTime.now().toIso8601String().substring(0, 10);
    final docId = '${uid}_$hoy';
    
    final doc = await _db.collection('habits').doc(docId).get();
    return doc.exists ? HabitModel.fromMap(doc.data()!) : null;
  }

  /// Lee los hábitos de una fecha específica
  Future<HabitModel?> leerPorFecha(String userId, String fecha) async {
    final docId = '${userId}_$fecha';
    
    final doc = await _db.collection('habits').doc(docId).get();
    return doc.exists ? HabitModel.fromMap(doc.data()!) : null;
  }

  /// Actualiza un campo específico del hábito del día
  Future<void> actualizarCampo(String userId, String fecha, String campo, dynamic valor) async {
    final docId = '${userId}_$fecha';
    
    await _db.collection('habits').doc(docId).update({
      campo: valor,
    });
  }

  /// Lee hábitos de un rango de fechas
  Future<List<HabitModel>> leerRangoFechas(String userId, String fechaInicio, String fechaFin) async {
    final query = await _db
        .collection('habits')
        .where('userId', isEqualTo: userId)
        .where('fecha', isGreaterThanOrEqualTo: fechaInicio)
        .where('fecha', isLessThanOrEqualTo: fechaFin)
        .get();
    
    return query.docs
        .map((doc) => HabitModel.fromMap(doc.data()))
        .toList();
  }

  /// Elimina el hábito de una fecha específica
  Future<void> eliminarHabito(String userId, String fecha) async {
    final docId = '${userId}_$fecha';
    
    await _db.collection('habits').doc(docId).delete();
  }
}