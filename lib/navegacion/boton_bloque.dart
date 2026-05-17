import 'package:flutter/material.dart';
import 'package:phoria_app/Screens/bloque_inicio/agregar_actividad.dart';

//boton de empezar bloque inicio, 
//lo que hace es navegar a la pantalla de agregar actividad, 
//donde se pueden agregar actividades al bloque
class Boton extends StatelessWidget {
  const Boton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,

      child: ElevatedButton(

        /// SOLO CAMBIASTE ESTO
        onPressed: () {

          Navigator.push(
            context,

            MaterialPageRoute(

              /// AQUI EL NOMBRE DE TU PANTALLA
              builder: (_) => const AgregarActividad(),

            ),
          );

        },

        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2D3561),
          foregroundColor: Colors.white,

          minimumSize: const Size(double.infinity, 68),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),

        child: const Text(
          'Empezar bloque',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}