import 'package:flutter/material.dart';

//boton para agregar tarea en la pantalla de tareas

class AgregarTarea extends StatelessWidget {

  // ───────── ACCIÓN DEL BOTÓN ─────────
  final VoidCallback onTap;

  const AgregarTarea({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      // ───────── QUÉ PASA AL TOCAR ─────────
      onTap: onTap,

      child: Container(
        width: double.infinity,
        height: 68,

        decoration: BoxDecoration(
          color: const Color(0xC6E2D4F2),

          borderRadius: BorderRadius.circular(25),

          border: Border.all(
            width: 2.5,
            color: const Color(0xFF848297),
          ),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // ───────── ICONO ─────────
            const Icon(
              Icons.add,
              color: Color(0xFF807F83),
              size: 26,
            ),

            const SizedBox(width: 10),

            // ───────── TEXTO ─────────
            const Text(
              'Agregar tarea',

              style: TextStyle(
                color: Color(0xFF807F83),
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}