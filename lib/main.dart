import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:hive/hive.dart';

import 'data/datasources/local/hive_service.dart';
import 'data/models/task_model.dart';

import 'package:flutter/material.dart';
import 'presentation/screens/login_screen.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

=======
import 'package:firebase_core/firebase_core.dart';
import 'package:phoria_app/firebase_options.dart';
import 'package:phoria_app/Screens/login/login_pantalla.dart';
import 'package:phoria_app/colores/temas.dart';
import 'package:phoria_app/navegacion/main_navegacion.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint('✓ Firebase inicializado correctamente');
  } catch (e) {
    debugPrint('✗ Error al inicializar Firebase: $e');
  }

>>>>>>> 46596b7 (Base,Login y Registro neuvo funcionales)
  runApp(const MyApp());
}

void unawaited(Future<void> future) {}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
      home: LoginScreen(),
=======
      title: 'Phoria',

      // ───────── Tema global ─────────
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Nunito',

        scaffoldBackgroundColor: AppColors.background,

        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),

      // Pantalla inicial 
      home: const LoginScreen(),
>>>>>>> 46596b7 (Base,Login y Registro neuvo funcionales)
    );
  }
}