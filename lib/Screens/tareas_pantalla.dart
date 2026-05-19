import 'package:flutter/material.dart';
import 'package:phoria_app/iu/tareas/agregar_tarea.dart';
import 'package:phoria_app/iu/tareas/formulario_agregar_tarea.dart';
import 'package:phoria_app/iu/tareas/header_tareas.dart';
import 'package:phoria_app/iu/tareas/pendientes.dart';
import 'package:phoria_app/iu/tareas/progreso_dia.dart';
import 'package:phoria_app/iu/tareas/tareas_hechas.dart';
import '../backend/services/task_service.dart';
import '../backend/models/task_model.dart';

class Tareas extends StatefulWidget {
  const Tareas({super.key});

  @override
  State<Tareas> createState() => _TareasState();
}

class _TareasState extends State<Tareas> {
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
                tiempoDisponible: '2 hrs 40 min',
                tareasCompletadas: 3,
                totalTareas: 5,
              ),
              const SizedBox(height: 30),
              const ProgresoDia(
                porcentaje: 60,
                xpGanado: 120,
              ),
              const SizedBox(height: 30),

              // ────── CARGAR TAREAS DINÁMICAMENTE ──────
              StreamBuilder<List<TaskModel>>(
                stream: TaskService().tareasStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }

                  final tareas = snapshot.data ?? [];

                  if (tareas.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.task_alt,
                            size: 64,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No hay tareas pendientes',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Column(
                    children: tareas.map((tarea) {
                      return Column(
                        children: [
                          Pendientes(
                            titulo: tarea.titulo,
                            descripcion:
                                '${tarea.dificultad} • +${tarea.xpReward}xp',
                            etiqueta: _formatoFecha(tarea.fecha),
                            etiquetaColor: _colorPorDificultad(tarea.dificultad),
                            textoEtiqueta: Colors.white,
                          ),
                          const SizedBox(height: 20),
                        ],
                      );
                    }).toList(),
                  );
                },
              ),

              // ────── TAREAS COMPLETADAS ──────
              StreamBuilder<List<TaskModel>>(
                stream: TaskService().tareasCompletadasStream(),
                builder: (context, snapshot) {
                  final tareasCompletas = snapshot.data ?? [];

                  if (tareasCompletas.isEmpty) {
                    return const SizedBox();
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Completadas',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...tareasCompletas.map((tarea) {
                        return Column(
                          children: [
                            TareasHechas(
                              titulo: tarea.titulo,
                              tiempoXp: '${tarea.dificultad} • +${tarea.xpReward}xp',
                            ),
                            const SizedBox(height: 20),
                          ],
                        );
                      }).toList(),
                    ],
                  );
                },
              ),

              AgregarTarea(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FormularioAgregarTarea(),
                    ),
                  ).then((_) {
                    setState(() {});
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ────── FORMATO DE FECHA ──────
  String _formatoFecha(DateTime fecha) {
    final hoy = DateTime.now();
    final diferencia = fecha.difference(hoy).inDays;

    if (diferencia == 0) return 'Hoy';
    if (diferencia == 1) return 'Mañana';
    if (diferencia < 7) return 'En $diferencia días';
    return '${fecha.day}/${fecha.month}';
  }

  // ────── COLOR POR DIFICULTAD ──────
  Color _colorPorDificultad(String dificultad) {
    switch (dificultad) {
      case 'facil':
        return const Color(0xFF4CAF50); // Verde
      case 'medio':
        return const Color(0xFFFFA500); // Naranja
      case 'dificil':
        return const Color(0xFFF44336); // Rojo
      default:
        return Colors.grey;
    }
  }
}