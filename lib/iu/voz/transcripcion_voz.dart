import 'package:flutter/material.dart';

class TranscripcionVoz extends StatelessWidget {

  // ───────── CAMBIAR TEXTO AQUÍ ─────────
  final String transcripcion;

  // ───────── BOTÓN MICRÓFONO ─────────
  final VoidCallback onMicTap;

  const TranscripcionVoz({
    super.key,
    required this.transcripcion,
    required this.onMicTap,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        // ───────── TRANSCRIPCIÓN ─────────
        Opacity(
          opacity: 0.9,

          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: const Color(0x608878C8),

              borderRadius: BorderRadius.circular(20),

              border: Border.all(
                color: const Color(0xFF8878C8),
                width: 3,
              ),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text(
                  'TRANSCRIPCIÓN EN VIVO',

                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 14),

                Opacity(
                  opacity: 0.6,

                  child: Text(
                    '"$transcripcion"',

                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 35),

        // ───────── MICRÓFONO ─────────
        GestureDetector(
          onTap: onMicTap,

          child: Container(
            width: 98,
            height: 93,

            decoration: BoxDecoration(
              color: const Color(0xFF2D3561),

              borderRadius: BorderRadius.circular(25),
            ),

            child: const Icon(
              Icons.mic,
              color: Colors.white,
              size: 42,
            ),
          ),
        ),

        const SizedBox(height: 20),

        // ───────── TEXTO ─────────
        Opacity(
          opacity: 0.6,

          child: const Text(
            'Toca y habla. Yo transcribo',

            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        const SizedBox(height: 24),

        // ───────── ONDAS DE AUDIO ─────────
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,

          children: const [

            AudioBar(height: 18),
            SizedBox(width: 6),

            AudioBar(height: 30),
            SizedBox(width: 6),

            AudioBar(height: 45),
            SizedBox(width: 6),

            AudioBar(height: 28),
            SizedBox(width: 6),

            AudioBar(height: 18),
            SizedBox(width: 6),

            AudioBar(height: 38),
            SizedBox(width: 6),

            AudioBar(height: 50),
          ],
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// BARRITAS DE AUDIO
// ─────────────────────────────────────────────

class AudioBar extends StatelessWidget {

  final double height;

  const AudioBar({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 5,
      height: height,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),

        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,

          colors: [
            Color(0xFF72C8C7),
            Color(0xFFB8B0D8),
          ],
        ),
      ),
    );
  }
}