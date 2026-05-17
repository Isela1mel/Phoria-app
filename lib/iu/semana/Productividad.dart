import 'package:flutter/material.dart';

class Productividad extends StatelessWidget {

  // ───────── CAMBIAR DATOS AQUÍ ─────────
  final List<double> valores;

  const Productividad({

    super.key,

    // 0.0 → 1.0
    // cada número representa un día
    required this.valores,
  });

  @override
  Widget build(BuildContext context) {

    final dias = ['L', 'M', 'M', 'J', 'V', 'S', 'D'];

    final colores = [
      const Color(0xFFC2C0CA),
      const Color(0xFF4AADA7),
      const Color(0xFFA77CF1),
      const Color(0xFFF2A7C3),
      const Color(0xFF4AADA7),
      const Color(0xFFB49CCF),
      const Color(0xFFDCD7F1),
    ];

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(24),

        border: Border.all(
          color: const Color(0xFFE5E0F3),
          width: 2,
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ───────── TITULO ─────────
          const Text(
            'PRODUCTIVIDAD POR DIA',

            style: TextStyle(
              color: Color(0xFF807F83),
              fontSize: 15,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 28),

          // ───────── GRAFICA ─────────
          SizedBox(
            height: 170,

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: List.generate(
                valores.length,
                (index) {

                  double altura = valores[index] * 120;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      AnimatedContainer(
                        duration: const Duration(milliseconds: 400),

                        width: 32,
                        height: altura.clamp(12, 120),

                        decoration: BoxDecoration(
                          color: colores[index],

                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        dias[index],

                        style: const TextStyle(
                          color: Color(0xFF807F83),
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
