import 'package:flutter/material.dart';

class VozHeader extends StatelessWidget {

  // ───────── CAMBIAR HORA AQUÍ ─────────
  final String hora;

  const VozHeader({
    super.key,
    required this.hora,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // ───────── HORA ─────────
        Opacity(
          opacity: 0.6,

          child: Text(
            hora,

            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),

        const SizedBox(height: 10),

        // ───────── TÍTULO ─────────
        const Text(
          'Cuéntame',

          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: 'Space Grotesk',
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 6),

        // ───────── SUBTÍTULO ─────────
        Opacity(
          opacity: 0.6,

          child: const Text(
            'Habla y yo anoto por ti',

            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}