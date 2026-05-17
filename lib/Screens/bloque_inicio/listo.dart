import 'package:flutter/material.dart';
import 'package:phoria_app/Screens/inicio.dart';
import 'package:phoria_app/iu/bloque_inicio/horarioheader.dart';
import 'package:phoria_app/iu/bloque_inicio/listo/listo_nombre.dart';
import 'package:phoria_app/iu/bloque_inicio/listo/nuevo_jugador.dart';
import 'package:phoria_app/iu/bloque_inicio/listo/tiempo_libre.dart';
import 'package:phoria_app/navegacion/boton_siguiente.dart';
import 'package:phoria_app/navegacion/main_navegacion.dart';

class Listo extends StatelessWidget {
  const Listo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              const HorarioHeader(currentStep: 0),
              const SizedBox(height: 200),

              const ListoNombre(
                // ───────── CAMBIAR NOMBRE AQUÍ ─────────
                userName: 'Melanie',
              ),

              const SizedBox(height: 50),

              const TiempoLibre(
                // ───────── CAMBIAR TIEMPO AQUÍ ─────────
                tiempoLibre: '2h 40m',
              ),
              const SizedBox(height: 50),
              const NuevoJugador(
                // ───────── CAMBIAR NIVEL AQUÍ ─────────
                level: 3,

                // ───────── CAMBIAR DESCRIPCIÓN AQUÍ ─────────
                description: '¡Nivel 3 alcanzado! Sigue así para desbloquear nuevas recompensas.',  
                // ───────── CAMBIAR PROGRESO AQUÍ (0.0 a 1.0) ─────────
                progress: 0.6,
              ),  

               const SizedBox(height: 50), 

              BotonSiguiente(
                text: 'Siguiente',
                onTap: () {
                   // ───────── CAMBIAR PANTALLA AQUÍ ─────────
                   Navigator.pushAndRemoveUntil(
                   context,

                    MaterialPageRoute(
                    builder: (_) => const MainNavegacion(),
                      ),
                       (route) => false,
                  );
                },
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}