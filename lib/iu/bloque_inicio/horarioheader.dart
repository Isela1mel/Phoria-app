import 'package:flutter/material.dart';

class HorarioHeader extends StatelessWidget {
  final int currentStep;

  const HorarioHeader({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        // Hora
        Opacity(
          opacity: 0.6,
          child: const Text(
            '6:30 am',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),

        // Puntitos
        Row(
          children: List.generate(
            3, // ← total de pantallas
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),

              width: 20,
              height: 20,

              decoration: BoxDecoration(
                color: currentStep == index
                    ? const Color(0xFF2D3561)
                    : const Color(0x14B3B3B3),

                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}