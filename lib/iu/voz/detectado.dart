import 'package:flutter/material.dart';

class Detectado extends StatelessWidget {

  // ───────── CAMBIAR MATERIA AQUÍ ─────────
  final String materia;

  // ───────── CAMBIAR TAREA AQUÍ ─────────
  final String tarea;

  const Detectado({
    super.key,
    required this.materia,
    required this.tarea,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // ───────── TEXTO SUPERIOR ─────────
        Opacity(
          opacity: 0.5,

          child: const Text(
            'Detectado automáticamente',

            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        const SizedBox(height: 14),

        // ───────── TAGS ─────────
        Wrap(
          spacing: 12,
          runSpacing: 12,

          children: [

            // ───────── MATERIA ─────────
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 8,
              ),

              decoration: BoxDecoration(
                color: const Color(0x3D8878C8),

                borderRadius: BorderRadius.circular(20),
              ),

              child: Text(
                materia,

                style: const TextStyle(
                  color: Color(0xFFAB6EED),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            // ───────── TAREA ─────────
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 8,
              ),

              decoration: BoxDecoration(
                color: const Color(0x4FE0F5F5),

                borderRadius: BorderRadius.circular(20),
              ),

              child: Text(
                tarea,

                style: const TextStyle(
                  color: Color(0xFF4AADA7),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}