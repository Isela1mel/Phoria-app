import 'package:flutter/material.dart';

class TiempoSue extends StatelessWidget {

  final String title;
  final String value;
  final VoidCallback onTap;

  const TiempoSue({
    super.key,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      // ───── Acción al tocar ─────
      onTap: onTap,

      child: Container(
        width: double.infinity,
        height: 74,

        padding: const EdgeInsets.symmetric(horizontal: 24),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(20),

          border: Border.all(
            color: Colors.black.withOpacity(0.15),
            width: 2,
          ),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            // ───── Texto izquierda ─────
            Opacity(
              opacity: 0.6,

              child: Text(
                title,

                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            // ───── Valor derecha ─────
            Text(
              value,

              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}