import 'package:flutter/material.dart';

class BotonSiguiente extends StatelessWidget {

  // Texto del botón
  final String text;

  // Acción del botón
  final VoidCallback onTap;

  const BotonSiguiente({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,

      child: ElevatedButton(

        // ───────── AQUÍ se ejecuta la acción ─────────
        onPressed: onTap,

        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2D3561),
          foregroundColor: Colors.white,

          minimumSize: const Size(double.infinity, 68),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),

        child: Text(
          text,

          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}