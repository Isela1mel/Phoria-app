import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // LOGIN
  Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {

    try {

      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Obtener el usuario completo desde Firestore
      final userDoc = await _db.collection('users').doc(userCredential.user!.uid).get();
      
      if (userDoc.exists) {
        final userModel = UserModel.fromMap(userDoc.data()!);
        
        return {
          'success': true,
          'message': 'Login exitoso',
          'userName': userModel.name,
        };
      }

      return {
        'success': true,
        'message': 'Login exitoso',
        'userName': 'Usuario',
      };

    } on FirebaseAuthException catch (e) {

      String errorMessage =
          'Error al iniciar sesión';

      if (e.code == 'user-not-found') {

        errorMessage = 'El usuario no existe';

      } else if (e.code == 'wrong-password') {

        errorMessage = 'Contraseña incorrecta';

      } else if (e.code == 'invalid-email') {

        errorMessage = 'Email inválido';

      } else if (e.code == 'user-disabled') {

        errorMessage =
            'El usuario ha sido deshabilitado';
      }

      return {
        'success': false,
        'message': errorMessage,
      };

    } catch (e) {

      return {
        'success': false,
        'message': 'Error desconocido',
      };
    }
  }

  // REGISTER
  Future<Map<String, dynamic>> register(
    String email,
    String password,
    String name,
  ) async {

    try {

      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Crear el usuario en Firestore
      final userModel = UserModel(
        name: name,
        email: email,
        level: 1,
        xp: 0,
        streak: 0,
        characterClass: 'Novato',
        createdAt: Timestamp.now(),
      );

      await _db.collection('users').doc(userCredential.user!.uid).set(userModel.toMap());

      return {
        'success': true,
        'message': 'Registro exitoso',
      };

    } on FirebaseAuthException catch (e) {

      String errorMessage =
          'Error al registrarse';

      if (e.code == 'weak-password') {

        errorMessage =
            'La contraseña es muy corta';

      } else if (e.code ==
          'email-already-in-use') {

        errorMessage =
            'Ese correo ya está registrado';

      } else if (e.code == 'invalid-email') {

        errorMessage = 'Correo inválido';
      }

      return {
        'success': false,
        'message': errorMessage,
      };

    } catch (e) {

      debugPrint('Error registrando usuario: $e');
      return {
        'success': false,
        'message': 'Error al registrarse: ${e.toString()}',
      };
    }
  }

  // LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
  }
}