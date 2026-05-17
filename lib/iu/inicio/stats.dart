import 'package:flutter/material.dart';

class Stats extends StatelessWidget {
  const Stats({super.key});

  // Datos que se conectan despues con el backend
  final int level = 7;
  final int currentXp = 640;
  final int maxXp = 1000;
  final int streakDays = 3;

  @override
  Widget build(BuildContext context) {
    final progress = currentXp / maxXp;

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

          // Título 
          const Text(
            'PLAYER STATS',
            style: TextStyle(
              color: Color(0xFF72C8C7),
              fontSize: 14,
              fontFamily: 'Press Start 2P',
            ),
          ),

          const SizedBox(height: 20),

          // Info principal 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Nivel
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'lv.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Press Start 2P',
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    level.toString().padLeft(2, '0'),
                    style: const TextStyle(
                      color: Color(0xFF72C8C7),
                      fontSize: 32,
                      fontFamily: 'Press Start 2P',
                    ),
                  ),
                ],
              ),

              // Racha
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Racha',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontFamily: 'Press Start 2P',
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    '$streakDays días',
                    style: const TextStyle(
                      color: Color(0xFFF2A7C3),
                      fontSize: 16,
                      fontFamily: 'Press Start 2P',
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 15),

          // experiencia
          Text(
            'XP - $currentXp / $maxXp',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontFamily: 'Press Start 2P',
            ),
          ),

          const SizedBox(height: 8),

          // Barra progreso 
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 18,
              backgroundColor: Colors.white,
              valueColor: const AlwaysStoppedAnimation(
                Color(0xFF72C8C7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}