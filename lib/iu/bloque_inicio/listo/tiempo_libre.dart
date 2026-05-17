import 'package:flutter/material.dart';

class TiempoLibre extends StatelessWidget {

  // ───────── Tiempo dinámico ─────────
  final String tiempoLibre;

  const TiempoLibre({
    super.key,
    required this.tiempoLibre,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 22,
      ),

      decoration: BoxDecoration(
        color: const Color(0xFFE0F5F5),

        borderRadius: BorderRadius.circular(30),

        border: Border.all(
          color: const Color(0xFF4AADA7),
        ),
      ),

      child: Column(
        children: [

          // ───────── Título ─────────
          const Text(
            'Tu tiempo libre promedio',

            textAlign: TextAlign.center,

            style: TextStyle(
              color: Color(0xFF4AADA7),
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 10),

          // ───────── Tiempo ─────────
          Text(
            tiempoLibre,

            style: const TextStyle(
              color: Colors.black,
              fontSize: 32,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 10),

          // ───────── Texto abajo ─────────
          Opacity(
            opacity: 0.5,

            child: const Text(
              'al día para ti.',

              textAlign: TextAlign.center,

              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}