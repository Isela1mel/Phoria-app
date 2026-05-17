import 'package:flutter/material.dart';

class Pendientes extends StatelessWidget {

  // ───────── CAMBIAR DATOS AQUÍ ─────────
  final String titulo;
  final String descripcion;
  final String etiqueta;

  final Color etiquetaColor;
  final Color textoEtiqueta;

  const Pendientes({
    super.key,
    required this.titulo,
    required this.descripcion,
    required this.etiqueta,
    required this.etiquetaColor,
    required this.textoEtiqueta,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: const Color(0xFFF8F5FF),

        borderRadius: BorderRadius.circular(20),

        border: Border.all(
          color: const Color(0xC6E2D4F2),
          width: 2,
        ),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ───────── CÍRCULO ─────────
          Container(
            width: 48,
            height: 48,

            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFF848297),
                width: 3,
              ),

              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 14),

          // ───────── TEXTO ─────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  titulo,

                  style: const TextStyle(
                    color: Color(0xFF1E1E1F),
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  descripcion,

                  style: const TextStyle(
                    color: Color(0xFF807F83),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // ───────── ETIQUETA ─────────
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 10,
            ),

            decoration: BoxDecoration(
              color: etiquetaColor,
              borderRadius: BorderRadius.circular(80),
            ),

            child: Text(
              etiqueta,

              style: TextStyle(
                color: textoEtiqueta,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}