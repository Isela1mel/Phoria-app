import 'package:flutter/material.dart';
import 'package:phoria_app/iu/tareas/agregar_tarea.dart';
import 'package:phoria_app/iu/tareas/header_tareas.dart';
import 'package:phoria_app/iu/tareas/pendientes.dart';
import 'package:phoria_app/iu/tareas/progreso_dia.dart';
import 'package:phoria_app/iu/tareas/tareas_hechas.dart';

class Tareas extends StatelessWidget {
  const Tareas({super.key});

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
             const HeaderTareas(

            // ───────── CAMBIAR TIEMPO AQUÍ ─────────
            tiempoDisponible: '2 hrs 40 min',
            // ───────── CAMBIAR TAREAS COMPLETADAS ─────────
            tareasCompletadas: 3,
            // ───────── CAMBIAR TOTAL DE TAREAS ─────────
            totalTareas: 5,
          ),

          const SizedBox(height: 30),

           const ProgresoDia(
        // ───────── CAMBIAR PORCENTAJE AQUÍ ─────────
        porcentaje: 60,
        // ───────── CAMBIAR XP AQUÍ ─────────
        xpGanado: 120,
      ),

          const SizedBox(height: 30),
              const Pendientes(
              titulo: 'Estudiar\nmatemáticas',

              descripcion:
                  'Derivadas • 1 hora • Alta\nprioridad',

              etiqueta: 'Hoy',

              etiquetaColor: Color(0xFFE3E3E5),

              textoEtiqueta: Color(0xFF2D3561),
            ),
            const SizedBox(height: 20),

            const TareasHechas(
              titulo: 'Leer cap. 10 Biología',

              tiempoXp: '45 min. +40xp',
            ),
            const SizedBox(height: 20),
            AgregarTarea(
                  // ───────── QUÉ HACE EL BOTÓN ─────────
                  onTap: () {
                    // abrir pantalla
                    // abrir modal
                    // agregar tarea
                    // etc
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}