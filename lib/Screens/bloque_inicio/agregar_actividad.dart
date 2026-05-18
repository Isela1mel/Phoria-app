import 'package:flutter/material.dart';
import 'package:phoria_app/Screens/bloque_inicio/agregar_descanso.dart';
import 'package:phoria_app/Screens/bloque_inicio/crear_actividad.dart';
import '../../iu/bloque_inicio/agregar_actividad/preguntahorario.dart';
import '../../iu/bloque_inicio/agregar_actividad/agergaractividad.dart';
import '../../iu/bloque_inicio/horarioheader.dart';
import '../../navegacion/boton_siguiente.dart';

class AgregarActividad extends StatefulWidget {
  const AgregarActividad({super.key});

  @override
  State<AgregarActividad> createState() => _AgregarActividadState();
}

class _AgregarActividadState extends State<AgregarActividad> {
  /// Lista de actividades creadas: {nombre, horaInicio, horaFin}
  final List<Map<String, String>> _actividades = [];

  /// Abre formulario para crear nueva actividad
  Future<void> _abrirCrearActividad() async {
    final resultado = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(builder: (_) => const CrearActividad()),
    );

    if (resultado != null) {
      setState(() {
        _actividades.add(resultado);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Actividad "${resultado['nombre']}" agregada'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  /// Elimina una actividad de la lista
  void _eliminarActividad(int index) {
    setState(() {
      _actividades.removeAt(index);
    });
  }

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
              SizedBox(height: 30),

              // ───────── LISTA DE ACTIVIDADES ─────────
              if (_actividades.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Actividades agregadas',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 12),
                    ..._actividades.asMap().entries.map((entry) {
                      int idx = entry.key;
                      Map<String, String> actividad = entry.value;
                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF72C8C7),
                            width: 2,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    actividad['nombre']!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${actividad['horaInicio']} - ${actividad['horaFin']}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF72C8C7),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, color: Colors.red),
                              onPressed: () => _eliminarActividad(idx),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 20),
                  ],
                ),

              // ───────── BOTÓN AGREGAR ACTIVIDAD ─────────
              Agergaractividad(onTap: _abrirCrearActividad),
              SizedBox(height: 30),

              BotonSiguiente(
                text: 'Siguiente',
                onTap: () {
                   Navigator.push(
                   context,
                    MaterialPageRoute(
                    builder: (_) => AgregarDescanso(
                      actividades: _actividades,
                    ),
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