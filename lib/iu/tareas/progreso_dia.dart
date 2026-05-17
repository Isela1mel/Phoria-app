import 'package:flutter/material.dart';

class ProgresoDia extends StatelessWidget {

  // ───────── CAMBIAR DATOS AQUÍ ─────────
  final int porcentaje;
  final int xpGanado;

  const ProgresoDia({
    super.key,
    required this.porcentaje,
    required this.xpGanado,
  });

  @override
  Widget build(BuildContext context) {

    // convierte 60 → 0.6
    double progreso = porcentaje / 100;

    return Container(
      width: double.infinity,

      // ───────── RESPONSIVE ─────────
      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: const Color(0xFFDFE0EF),

        borderRadius: BorderRadius.circular(20),

        border: Border.all(
          color: const Color(0xFFB49CCF),
          width: 2,
        ),

        boxShadow: const [
          BoxShadow(
            color: Color(0xFFB59CCF),
            offset: Offset(-8, 8),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ───────── HEADER ─────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              const Expanded(
                child: Text(
                  'Progreso del dia',

                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),

                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(width: 10),

              Text(
                '$porcentaje%',

                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // ───────── BARRA DE PROGRESO ─────────
          ClipRRect(
            borderRadius: BorderRadius.circular(30),

            child: LinearProgressIndicator(
              value: progreso,
              minHeight: 18,

              backgroundColor: Colors.white,

              valueColor: const AlwaysStoppedAnimation(
                Color(0xFFB49CF7),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ───────── XP GANADO ─────────
          Text(
            '+$xpGanado xp ganados hoy',

            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

