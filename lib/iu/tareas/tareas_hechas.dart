import 'package:flutter/material.dart';

class TareasHechas extends StatelessWidget {

  // ───────── CAMBIAR DATOS AQUÍ ─────────
  final String titulo;
  final String tiempoXp;

  const TareasHechas({
    super.key,
    required this.titulo,
    required this.tiempoXp,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),

      decoration: BoxDecoration(
        color: const Color(0xFFF8F6FF),

        borderRadius: BorderRadius.circular(20),

        border: Border.all(
          color: const Color(0xC6E2D4F2),
          width: 2,
        ),
      ),

      child: Row(
        children: [

          // ───────── CHECK ─────────
          Container(
            width: 34,
            height: 34,

            decoration: const BoxDecoration(
              color: Color(0xFF7AC3AC),
              shape: BoxShape.circle,
            ),

            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 22,
            ),
          ),

          const SizedBox(width: 14),

          // ───────── TEXTO ─────────
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                titulo,

                style: const TextStyle(
                  color: Color(0xFFC4C3C9),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                tiempoXp,

                style: const TextStyle(
                  color: Color(0xFF807F83),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}