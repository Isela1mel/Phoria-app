import 'package:flutter/material.dart';

class PreguntaHorario extends StatelessWidget {
  const PreguntaHorario({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [

        // ───────── Título ─────────
        Text(
          '¿Cómo es tu día?',
          textAlign: TextAlign.center,

          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
        ),

        SizedBox(height: 12),

        // ───────── Descripción ─────────
        Opacity(
          opacity: 0.5,

          child: Text(
            'Dime tu horario fijo y yo calculo cuánto tiempo libre tienes cada día',

            textAlign: TextAlign.center,

            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}