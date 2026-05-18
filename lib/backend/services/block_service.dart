import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/block_model.dart'; // Importamos BlockModel

class BlockService {
  final _db = FirebaseFirestore.instance;

  /// Inicia un bloque y retorna el BlockModel completo
  Future<BlockModel> iniciarBloque(String uid, String taskId, String metodo) async {
    final doc = await _db.collection('blocks').add({
      'userId': uid,
      'taskId': taskId,
      'metodo': metodo,
      'iniciadoEn': FieldValue.serverTimestamp(),
      'terminadoEn': null,
      'cancelado': false,
      'xpGanado': 0,
    });
    
    // Convertimos el DocumentSnapshot a BlockModel usando fromMap()
    final snapshot = await doc.get();
    return BlockModel.fromMap({...snapshot.data() as Map, 'id': doc.id});
  }

  /// Obtiene un bloque por ID
  Future<BlockModel?> obtenerBloque(String blockId) async {
    final doc = await _db.collection('blocks').doc(blockId).get();
    if (!doc.exists) return null;
    return BlockModel.fromMap({...doc.data() as Map, 'id': doc.id});
  }

  /// Termina un bloque cuando el timer llega a 0
  Future<BlockModel> terminarBloque(String blockId) async {
    final ahora = FieldValue.serverTimestamp();
    await _db.collection('blocks').doc(blockId).update({
      'terminadoEn': ahora,
      'cancelado': false,
      'xpGanado': 50,
    });
    
    // Retornamos el BlockModel actualizado
    return obtenerBloque(blockId) as Future<BlockModel>;
  }

  /// Cancela un bloque si el usuario lo detiene
  Future<BlockModel> cancelarBloque(String blockId) async {
    final ahora = FieldValue.serverTimestamp();
    await _db.collection('blocks').doc(blockId).update({
      'terminadoEn': ahora,
      'cancelado': true,
      'xpGanado': 0,
    });
    
    // Retornamos el BlockModel actualizado
    return obtenerBloque(blockId) as Future<BlockModel>;
  }
}