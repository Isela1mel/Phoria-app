import 'package:flutter/material.dart';
import 'package:phoria_app/iu/voz/detectado.dart';
import 'package:phoria_app/iu/voz/guardar_nota.dart';
import 'package:phoria_app/iu/voz/transcripcion_voz.dart';
import 'package:phoria_app/iu/voz/voler_guardar.dart';
import 'package:phoria_app/iu/voz/voz_heater.dart';

class Voz extends StatelessWidget {
  const Voz({super.key});

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
              const VozHeader(
                // ───────── CAMBIAR HORA AQUÍ ─────────
                hora: '6:30 am',
              ),
              const SizedBox(height: 30),
              TranscripcionVoz(
                  // ───────── CAMBIAR TEXTO AQUÍ ─────────
                  transcripcion: 'Tengo tarea de programación para mañana y un proyecto de matemáticas para el viernes',

                  // ───────── ACCIÓN DEL MICRÓFONO AQUÍ ─────────
                  onMicTap: () {
                    print('Micrófono presionado');
                  },
                ),
                SizedBox(height: 30),
              const Detectado(

                  // ───────── CAMBIAR MATERIA AQUÍ ─────────
                  materia: 'Matemáticas',

                  // ───────── CAMBIAR TAREA AQUÍ ─────────
                  tarea: 'Ejr 13',
                ),
              const SizedBox(height: 30),
              GuardarNota(
                                
                  // ───────── ACCIÓN DEL BOTÓN AQUÍ ─────────
                  onTap: () {

                    print('Nota guardada');

                    // Navigator.push(...)
                  },
                ),
              const SizedBox(height: 20),
              VolerGuardar(              
                    // ───────── ACCIÓN DEL BOTÓN AQUÍ ─────────
                    onTap: () {

                      print('Volver a grabar');

                      // limpiar texto
                      // iniciar grabación otra vez
                      // Navigator.push(...)
                    },
                ),
            ],
          ),
        ),
      ),
    );
  }
}