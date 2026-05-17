import 'package:flutter/material.dart';

class bloques extends StatelessWidget {
  const bloques({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [

        // ───────── Título ─────────
        Opacity(
          opacity: 0.5,
          child: Text(
            'HOY EN MIS BLOQUES',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),

        SizedBox(height: 16),

        // ───────── Bloques ─────────
        BloqueCard(
          title: 'Escuela',
          time: '7:00 - 14:00',
          tag: 'Fijo',
          isFixed: true,
        ),

        SizedBox(height: 12),

        BloqueCard(
          title: 'Estudiar Java',
          time: '15:30 - 17:00',
          tag: 'Hoy',
        ),
      ],
    );
  }
}

class BloqueCard extends StatelessWidget {
  final String title;
  final String time;
  final String tag;
  final bool isFixed;

  const BloqueCard({
    super.key,
    required this.title,
    required this.time,
    required this.tag,
    this.isFixed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: const Color(0xFFEEEAF8),
        borderRadius: BorderRadius.circular(20),

        boxShadow: const [
          BoxShadow(
            color: Color(0x3FB8B0D8),
            offset: Offset(-4, 4),
          ),
        ],
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          // ───────── Información ─────────
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 8),

              Opacity(
                opacity: 0.5,
                child: Text(
                  time,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          // ───────── Etiqueta ─────────
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 6,
            ),

            decoration: BoxDecoration(
              color: isFixed
                  ? const Color(0xFFE0F5F5)
                  : const Color(0x68B8B0D8),

              borderRadius: BorderRadius.circular(20),
            ),

            child: Text(
              tag,
              style: TextStyle(
                color: isFixed
                    ? const Color(0xFF4AADA7)
                    : const Color(0xFF8878C8),

                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}