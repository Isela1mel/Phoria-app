import 'package:flutter/material.dart';

class HeaderTareas extends StatelessWidget {

  // ───────── CAMBIAR DATOS AQUÍ ─────────
  final String tiempoDisponible;
  final int tareasCompletadas;
  final int totalTareas;

  const HeaderTareas({
    super.key,
    required this.tiempoDisponible,
    required this.tareasCompletadas,
    required this.totalTareas,
  });

  @override
  Widget build(BuildContext context) {

    // porcentaje para la barra
    double progreso = tareasCompletadas / totalTareas;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // ───────── TÍTULO ─────────
        const Text(
          'Mis Tareas',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 8),

        // ───────── TIEMPO DISPONIBLE ─────────
        Text(
          '$tiempoDisponible disponibles',
          style: const TextStyle(
            color: Color(0xFF9B9DE0),
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 20),

        // ───────── BARRA DE PROGRESO ─────────
        Stack(
          children: [

            // fondo
            Container(
              width: double.infinity,
              height: 42,

              decoration: BoxDecoration(
                color: const Color(0xFFE4E4E4),
                borderRadius: BorderRadius.circular(70),
              ),
            ),

            // progreso
            Container(
              width: MediaQuery.of(context).size.width * progreso * 0.8,
              height: 42,

              decoration: BoxDecoration(
                color: const Color(0xFF2D3561),
                borderRadius: BorderRadius.circular(70),
              ),
            ),

            // texto centrado
            SizedBox(
              height: 42,
              width: double.infinity,

              child: Center(
                child: Text(
                  '$tareasCompletadas/$totalTareas',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}