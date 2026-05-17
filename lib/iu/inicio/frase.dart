import 'package:flutter/material.dart';

class Frase extends StatelessWidget {
  const Frase({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2D3561),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),

      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Frase del día',
            style: TextStyle(
              color: Color(0xFF72C8C7),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 15),

          Text(
            '“Si puedes imaginarlo,\npuedes programarlo”\n\n- Anónimo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}