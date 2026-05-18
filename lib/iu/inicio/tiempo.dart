import 'package:flutter/material.dart';


// CAMBIO: ahora el widget recibe los datos por parámetro, no hardcodeados
class Tiempo extends StatelessWidget {
  final String freeTime;
  final int percentage;
  const Tiempo({super.key, required this.freeTime, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: const Color(0xFFE0F5F5),
        border: Border.all(
          color: const Color(0xFF4AADA7),
        ),
        borderRadius: BorderRadius.circular(30),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ───────── Parte superior ─────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Texto
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    'TIEMPO LIBRE HOY',
                    style: TextStyle(
                      color: Color(0xFF4AADA7),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    freeTime,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              // Porcentaje
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),

                decoration: BoxDecoration(
                  color: const Color(0xFF4AADA7),
                  borderRadius: BorderRadius.circular(15),
                ),

                child: Column(
                  children: [

                    Text(
                      '$percentage%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    const Text(
                      'libre',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // ───────── Barra progreso ─────────
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: LinearProgressIndicator(
              value: percentage / 100,
              minHeight: 18,
              backgroundColor: Colors.white,
              valueColor: const AlwaysStoppedAnimation(
                Color(0xFF4AADA7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}