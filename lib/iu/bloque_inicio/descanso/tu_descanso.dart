import 'package:flutter/material.dart';

class TuDescanso extends StatelessWidget {
  const TuDescanso({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [

        // Título
        Text(
          'Tu descanso importa',
          textAlign: TextAlign.center,

          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),

        SizedBox(height: 12),

        // Descripción
        Opacity(
          opacity: 0.6,

          child: Text(
            'No voy a meterte tareas en tu tiempo de sueño.',
            textAlign: TextAlign.center,

            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}