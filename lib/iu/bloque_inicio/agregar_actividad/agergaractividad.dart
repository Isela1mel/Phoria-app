import 'package:flutter/material.dart';

class Agergaractividad extends StatelessWidget {
  final VoidCallback onTap;

   Agergaractividad({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        width: double.infinity,
        height: 74,

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),

          border: Border.all(
            color: Colors.black.withOpacity(0.2),
            width: 2,
          ),
        ),

        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              Icons.add,
              color: Colors.black54,
            ),

            SizedBox(width: 10),

            Text(
              'Agregar actividad',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}