import 'package:flutter/material.dart';

class HeaderSemana extends StatelessWidget {

  // ───────── CAMBIAR DATOS AQUÍ ─────────
  final int tareasCompletadas;
  final int tareasTotales;
  final int semana;

  const HeaderSemana({
    super.key,
    required this.tareasCompletadas,
    required this.tareasTotales,
    required this.semana,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        // ───────── TEXTO IZQUIERDA ─────────
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              'Mi Semana',

              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              '$tareasCompletadas/$tareasTotales tareas completadas',

              style: const TextStyle(
                color: Color(0xFF9B9DE0),
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),

        // ───────── PANEL SEMANA ─────────
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 10,
          ),

          decoration: BoxDecoration(
            color: const Color(0xFFC8FAFA),

            borderRadius: BorderRadius.circular(70),
          ),

          child: Text(
            'Sem. $semana',

            style: const TextStyle(
              color: Color(0xFF16ABA2),
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}