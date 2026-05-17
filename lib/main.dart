import 'package:flutter/material.dart';
import 'package:phoria_app/Screens/inicio.dart';
import 'package:phoria_app/colores/temas.dart';
import 'package:phoria_app/navegacion/main_navegacion.dart';

void main() {
  runApp(const MyApp());
}

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
      home: const MainNavegacion(),
    );
  }
}