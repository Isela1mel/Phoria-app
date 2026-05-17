import 'package:flutter/material.dart';
import 'package:phoria_app/Screens/inicio.dart';
import 'package:phoria_app/Screens/semana_pantalla.dart';
import 'package:phoria_app/Screens/tareas_pantalla.dart';
import 'package:phoria_app/Screens/voz_pantalla.dart';

class MainNavegacion extends StatefulWidget {
  const MainNavegacion({super.key});

  @override
  State<MainNavegacion> createState() => _MainNavegacionState();
}

class _MainNavegacionState extends State<MainNavegacion> {

  // ───── Pantalla actual ─────
  int currentIndex = 0;

  // ───── Lista de pantallas ─────
  final List<Widget> screens = [
    const Inicio(),
    const Tareas(),
    const Voz(),
    const SemanaPantalla(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ───── Pantalla que cambia ─────
      body: screens[currentIndex],
      // ───── Barra inferior ─────
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,

        backgroundColor: const Color(0xFFEDE8E0),

        selectedItemColor: const Color(0xFF2D3561),
        unselectedItemColor: Colors.black54,

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Inicio',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: 'Tareas',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.mic_none),
            label: 'Voz',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Semana',
          ),
        ],
      ),
    );
  }
}
