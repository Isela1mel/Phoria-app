import 'package:flutter/material.dart';

class VolerGuardar extends StatelessWidget {

  // ───────── ACCIÓN DEL BOTÓN ─────────
  final VoidCallback onTap;

  // ───────── CAMBIAR TEXTO AQUÍ ─────────
  final String texto;

  const VolerGuardar({
    super.key,
    required this.onTap,

    this.texto = 'Volver a grabar',
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: double.infinity,

      child: OutlinedButton(
        onPressed: onTap,

        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xC6E7E7F2),

          minimumSize: const Size(
            double.infinity,
            64,
          ),

          side: const BorderSide(
            width: 2.5,
            color: Color(0xFFB49CCF),
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),

        child: Text(
          texto,

          style: const TextStyle(
            color: Color(0xFFAB6EED),
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}