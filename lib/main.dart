import 'package:flutter/material.dart';
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

  runApp(const MyApp());
}

void unawaited(Future<void> future) {}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      // ───────── Configuración ─────────
      debugShowCheckedModeBanner: false,
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
    );
  }
}