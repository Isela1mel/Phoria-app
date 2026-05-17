import 'package:flutter/material.dart';

class ListoNombre extends StatelessWidget {

  // ───────── Nombre dinámico ─────────
  final String userName;

  const ListoNombre({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ───────── Título ─────────
        Text(
          '¡Listo $userName!',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        // ───────── Descripción ─────────
        Opacity(
          opacity: 0.5,

          child: const Text(
            'Cada mañana calculo tu tiempo disponible automáticamente. No tienes que hacer nada extra.',

            textAlign: TextAlign.center,

            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}