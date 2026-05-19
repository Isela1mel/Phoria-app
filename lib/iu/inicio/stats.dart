import 'package:flutter/material.dart';
import '../../backend/services/xp_service.dart';

class Stats extends StatelessWidget {
  const Stats({super.key});

  int _xpParaNivel(int nivel) {
    // Fórmula simple: cada nivel requiere 100 + 50*(nivel-1) XP
    if (nivel <= 1) return 100;
    return 100 + 50 * (nivel - 1);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, dynamic>>(
      stream: XpService().xpStream(),
      builder: (context, snapshot) {
        final data = snapshot.data ?? {'xpTotal': 0, 'nivel': 1, 'streak': 0};
        final nivel = data['nivel'] ?? 1;
        final xpTotal = data['xpTotal'] ?? 0;
        final streak = data['streak'] ?? 0;
        final maxXp = _xpParaNivel(nivel);
        final prevXp = _xpParaNivel(nivel - 1);
        final currentXp = xpTotal - prevXp;
        final progress = (currentXp / (maxXp - prevXp)).clamp(0.0, 1.0);

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
              const Text(
                'PLAYER STATS',
                style: TextStyle(
                  color: Color(0xFF72C8C7),
                  fontSize: 14,
                  fontFamily: 'Press Start 2P',
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        nivel.toString().padLeft(2, '0'),
                        style: const TextStyle(
                          color: Color(0xFF72C8C7),
                          fontSize: 32,
                          fontFamily: 'Press Start 2P',
                        ),
                      ),
                    ],
                  ),
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
                        '$streak días',
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
              Text(
                'XP - $currentXp / ${maxXp - prevXp}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontFamily: 'Press Start 2P',
                ),
              ),
              const SizedBox(height: 8),
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
      },
    );
  }
}