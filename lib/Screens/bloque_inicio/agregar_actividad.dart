import 'package:flutter/material.dart';
import 'package:phoria_app/Screens/bloque_inicio/agregar_descanso.dart';
import '../../iu/bloque_inicio/agregar_actividad/preguntahorario.dart';
import '../../iu/bloque_inicio/agregar_actividad/agergaractividad.dart';
import '../../iu/bloque_inicio/agregar_actividad/bloque.dart';
import '../../iu/bloque_inicio/horarioheader.dart';
import '../../navegacion/boton_siguiente.dart';


class AgregarActividad extends StatelessWidget {
  const AgregarActividad({super.key});

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
              SizedBox(height: 30),
   
              PreguntaHorario(),
              SizedBox(height: 20),
    
              Bloque(title: 'Título del bloque', value: 'Valor del bloque'),

              SizedBox(height: 20),
              Agergaractividad(onTap: () {}),
              SizedBox(height: 20),
              BotonSiguiente(
                text: 'Siguiente',
                onTap: () {
                   // ───────── CAMBIAR PANTALLA AQUÍ ─────────
                   Navigator.push(
                   context,

                    MaterialPageRoute(
                    builder: (_) => const AgregarDescanso(),
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