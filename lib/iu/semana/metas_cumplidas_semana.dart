import 'package:flutter/material.dart';

class MetasCumplidasSemana extends StatelessWidget {

  // ───────── CAMBIAR DATOS AQUÍ ─────────
  final int metasCumplidas;
  final int mejoraSemanal;

  final double concentracion;
  final double constancia;
  final double bienestar;

  const MetasCumplidasSemana({
    super.key,
    required this.metasCumplidas,
    required this.mejoraSemanal,
    required this.concentracion,
    required this.constancia,
    required this.bienestar,
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

          // ───────── HEADER ─────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              // ───────── IZQUIERDA ─────────
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  const Text(
                    'Metas cumplidas',

                    style: TextStyle(
                      color: Color(0xFFB8B0D8),
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    '$metasCumplidas%',

                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),

              // ───────── PANEL DERECHA ─────────
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),

                decoration: BoxDecoration(
                  color: const Color(0xFF434A6D),

                  borderRadius: BorderRadius.circular(18),
                ),

                child: Column(
                  children: [

                    Text(
                      '+$mejoraSemanal%',

                      style: const TextStyle(
                        color: Color(0xFF16ABA2),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      'vs. sem pasada',

                      style: TextStyle(
                        color: Color(0xFF807F83),
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          // ───────── STATS ─────────
          const Text(
            'Stats de la semana',

            style: TextStyle(
              color: Color(0xFF16ABA2),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 20),

          // ───────── BARRAS ─────────
          StatBar(
            titulo: 'Concentración',
            progreso: concentracion,
            color: const Color(0xFF72C8C7),
          ),

          const SizedBox(height: 14),

          StatBar(
            titulo: 'Constancia',
            progreso: constancia,
            color: const Color(0xFFF2A7C3),
          ),

          const SizedBox(height: 14),

          StatBar(
            titulo: 'Bienestar',
            progreso: bienestar,
            color: const Color(0xFFB8B0D8),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// BARRA INDIVIDUAL
// ─────────────────────────────────────────────

class StatBar extends StatelessWidget {

  final String titulo;
  final double progreso;
  final Color color;

  const StatBar({
    super.key,
    required this.titulo,
    required this.progreso,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [

        SizedBox(
          width: 120,

          child: Text(
            titulo,

            style: const TextStyle(
              color: Color(0xFFBEBEBE),
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),

            child: LinearProgressIndicator(
              value: progreso,
              minHeight: 18,

              backgroundColor: Colors.white,

              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ),
      ],
    );
  }
}