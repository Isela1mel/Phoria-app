import 'package:flutter/material.dart';

class Monitoreo extends StatelessWidget {

  // ───────── Lista de apps ─────────
  final List<String> apps;

  // ───────── Botón agregar ─────────
  final VoidCallback onAdd;

  // ───────── Tap en app ─────────
  final Function(String app)? onRemove;

  const Monitoreo({
    super.key,
    required this.apps,
    required this.onAdd,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // ───────── Título ─────────
        Opacity(
          opacity: 0.6,

          child: const Text(
            'Apps a monitorear y bloquear:',

            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        const SizedBox(height: 16),

        // ───────── Apps ─────────
        Wrap(
          spacing: 12,
          runSpacing: 12,

          children: [

            // ───────── Apps dinámicas ─────────
            ...apps.map(
              (app) => GestureDetector(

                // ───── Eliminar app ─────
                onTap: () {

                  // ───── AQUÍ puedes eliminar ─────
                  if (onRemove != null) {
                    onRemove!(app);
                  }
                },

                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 8,
                  ),

                  decoration: BoxDecoration(
                    color: const Color(0x4FFB5858),
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Text(
                    app,

                    style: const TextStyle(
                      color: Color(0xFFF82B2B),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),

            // ───────── Botón agregar ─────────
            GestureDetector(
              onTap: onAdd,

              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 8,
                ),

                decoration: BoxDecoration(
                  color: const Color(0x66E8C547),
                  borderRadius: BorderRadius.circular(20),
                ),

                child: const Text(
                  'Agregar',

                  style: TextStyle(
                    color: Color(0xFF92400E),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}