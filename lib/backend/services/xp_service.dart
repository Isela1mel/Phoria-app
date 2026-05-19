import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class XpService {
  final _db = FirebaseFirestore.instance;
  String get _uid => FirebaseAuth.instance.currentUser!.uid;

  // Suma XP y actualiza el nivel automáticamente
  Future<void> sumarXp(int xp) async {
    final ref = _db.collection('users').doc(_uid);
    final doc = await ref.get();
    final xpActual = (doc.data()?['xpTotal'] ?? 0) as int;
    final xpNuevo = xpActual + xp;
    final nivelNuevo = calcularNivel(xpNuevo);
    await ref.set({
      'xpTotal': xpNuevo,
      'nivel': nivelNuevo,
    }, SetOptions(merge: true));
  }

  // Fórmula de nivel
  static int calcularNivel(int xp) {
    if (xp < 100) return 1;
    if (xp < 250) return 2;
    if (xp < 500) return 3;
    return (xp / 150).floor() + 1;
  }

  // Leer XP y nivel actual (para el dashboard)
  Stream<Map<String, dynamic>> xpStream() {
    return _db
      .collection('users')
      .doc(_uid)
      .snapshots()
      .map((doc) => doc.data() ?? {'xpTotal': 0, 'nivel': 1});
  }
}