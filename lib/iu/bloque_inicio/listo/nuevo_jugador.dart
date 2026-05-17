import 'package:flutter/material.dart';

class NuevoJugador extends StatelessWidget {

  // ───────── Nivel ─────────
  final int level;

  // ───────── Texto progreso ─────────
  final String description;

  // ───────── Progreso barra ─────────
  final double progress;

  const NuevoJugador({
    super.key,
    required this.level,
    required this.description,

    // 0.0 a 1.0
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: const Color(0xFF2D3561),

        borderRadius: BorderRadius.circular(20),

        boxShadow: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ───────── Título ─────────
          const Text(
            'Nuevo jugador',

            style: TextStyle(
              color: Color(0xFF72C8C7),
              fontSize: 14,
              fontFamily: 'PressStart2P',
              fontWeight: FontWeight.w400,
            ),
          ),

          const SizedBox(height: 16),

          // ───────── Texto nivel ─────────
          Opacity(
            opacity: 0.6,

            child: Text(
              'Lv.${level.toString().padLeft(2, '0')} - $description',

              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontFamily: 'PressStart2P',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          const SizedBox(height: 14),

          // ───────── Barra progreso ─────────
          Container(
            width: double.infinity,
            height: 19,

            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.circular(30),

              border: Border.all(
                color: Colors.black26,
                width: 2,
              ),
            ),

            child: Align(
              alignment: Alignment.centerLeft,

              child: FractionallySizedBox(

                // ───── PROGRESO AQUÍ ─────
                widthFactor: progress,

                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),

                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF72C8C7),
                        Color(0xFF5409D6),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}