import 'package:flutter/material.dart';
import 'package:phoria_app/Screens/bloque_inicio/listo.dart';
import 'package:phoria_app/iu/bloque_inicio/descanso/monitoreo.dart';
import 'package:phoria_app/iu/bloque_inicio/descanso/tiempo_sue.dart';
import 'package:phoria_app/navegacion/boton_siguiente.dart';
import '../../iu/bloque_inicio/descanso/tu_descanso.dart';
import '../../iu/bloque_inicio/horarioheader.dart';

class AgregarDescanso extends StatelessWidget {
  const AgregarDescanso({super.key});

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
              SizedBox(height: 20),
              HorarioHeader(currentStep: 0),
              SizedBox(height: 250),
   
              TuDescanso(),
              SizedBox(height: 70),
  
                TiempoSue(
                title: 'Hora de levantarse',
                value: '5:00 am',
                onTap: () {
                  // AQUÍ abres reloj
                },
              ),
              SizedBox(height: 16),
              // ───────── Horas de sueño ─────────

              TiempoSue(
                title: 'Horas mínimas de sueño',
                value: '7 horas',
                onTap: () {
                  // AQUÍ abres selector
                },
              ),
              SizedBox(height: 40),

              Monitoreo(
                        // ───────── Apps actuales ─────────
                        apps: const [
                          'TikTok',
                          'Instagram',
                          'YouTube',
                        ],
                      // ───────── Botón agregar ─────────
                      onAdd: () {
                        // AQUÍ abres selector de apps
                      },
                      // ───────── Eliminar app ─────────
                      onRemove: (app) {
                        // AQUÍ eliminas app
                        print(app);
                      },
                    ),
                    SizedBox(height: 20),
                
                BotonSiguiente(
                text: 'Siguiente',
                onTap: () {
                   // ───────── CAMBIAR PANTALLA AQUÍ ─────────
                   Navigator.push(
                   context,

                    MaterialPageRoute(
                    builder: (_) => const Listo(),
                      ),
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
                      
                     