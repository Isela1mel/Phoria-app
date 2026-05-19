import 'package:flutter/material.dart';

class ActividadEnCurso extends StatelessWidget {

  // ───────── DATOS DINÁMICOS (BACKEND) ─────────
  final String titulo;
  final String subtitulo;
  final int porcentaje;
  final String tiempoRestante;
  final VoidCallback onCompletar;
  final VoidCallback onCancelar;

  const ActividadEnCurso({
    super.key,
    required this.titulo,
    required this.subtitulo,
    required this.porcentaje,
    required this.tiempoRestante,
    required this.onCompletar,
    required this.onCancelar,
  });

  @override
  Widget build(BuildContext context) {
    double progreso = porcentaje / 100;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2D3561),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ───────── HEADER ─────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFE0F5F5),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              'Actividad en curso',
              style: TextStyle(
                color: Color(0xFF4AADA7),
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 30),
          // ───────── TARJETA ACTIVIDAD ─────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              color: const Color(0xFFEDEAF8).withOpacity(0.8),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                if (subtitulo.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      subtitulo,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: progreso.clamp(0.0, 1.0),
                  minHeight: 8,
                  backgroundColor: Colors.grey[300],
                  color: const Color(0xFF4AADA7),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('$porcentaje% completado'),
                    Text(tiempoRestante),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onCompletar,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4AADA7),
                        ),
                        child: const Text('Terminada'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onCancelar,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF2D3561),
                          side: const BorderSide(color: Color(0xFF2D3561)),
                        ),
                        child: const Text('No completada'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}