import 'package:flutter/material.dart';

class GuardarNota extends StatelessWidget {

  // ───────── ACCIÓN DEL BOTÓN ─────────
  final VoidCallback onTap;

  // ───────── CAMBIAR TEXTO AQUÍ ─────────
  final String texto;

  const GuardarNota({
    super.key,
    required this.onTap,

    this.texto = 'Guardar nota',
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: double.infinity,

      child: ElevatedButton(
        onPressed: onTap,

        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2D3561),
          foregroundColor: Colors.white,

          minimumSize: const Size(
            double.infinity,
            68,
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),

        child: Text(
          texto,

          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}