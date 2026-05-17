import 'package:flutter/material.dart';

class Patrones extends StatelessWidget {
  const Patrones({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(24),

        border: Border.all(
          color: const Color(0xFFE4E1F1),
          width: 2,
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ───────── TITULO ─────────
          const Text(
            'PATRONES DETECTADOS',

            style: TextStyle(
              color: Color(0xFF807F83),
              fontSize: 15,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 24),

          // ───────── PATRON 1 ─────────
          _patronItem(
            color: const Color(0xFFE84B36),

            texto:
                'El jueves dormiste 5h - 2 desvíos.\n'
                'El sueño afecta directamente tu concentración.',
          ),

          const SizedBox(height: 18),

          _divider(),

          const SizedBox(height: 18),

          // ───────── PATRON 2 ─────────
          _patronItem(
            color: const Color(0xFF4AADA7),

            texto:
                'Los martes rindes 40% más.\n'
                'Es tu mejor día para tareas difíciles.',
          ),

          const SizedBox(height: 18),

          _divider(),

          const SizedBox(height: 18),

          // ───────── PATRON 3 ─────────
          _patronItem(
            color: const Color(0xFFAB6EED),

            texto:
                '3 bloques completados ✅\n'
                '1 cancelado ❌ • +340 XP ganados.',
          ),
        ],
      ),
    );
  }

  // ───────── ITEM ─────────
  Widget _patronItem({
    required Color color,
    required String texto,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // PUNTO
        Container(
          margin: const EdgeInsets.only(top: 6),

          width: 14,
          height: 14,

          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),

        const SizedBox(width: 14),

        // TEXTO
        Expanded(
          child: Text(
            texto,

            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  // ───────── LINEA ─────────
  Widget _divider() {
    return Container(
      width: double.infinity,
      height: 2,

      decoration: BoxDecoration(
        color: const Color(0xFFE2E2E2),

        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}