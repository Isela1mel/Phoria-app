import 'package:flutter/material.dart';
import '../colores/temas.dart';
import '../iu/inicio/header.dart';
import '../iu/inicio/frase.dart';
import '../iu/inicio/stats.dart';
import '../iu/inicio/tiempo.dart';
import '../iu/inicio/bloques.dart';
import '../navegacion/boton_bloque.dart';

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 20),
              header(),
              SizedBox(height: 30),
   
              Frase(),
              SizedBox(height: 20),
    
              Stats(),

              SizedBox(height: 20),
              tiempo(),
              SizedBox(height: 20),
              bloques(),
              SizedBox(height: 20),
              Boton(),
            ],
          ),
        ),
      ),
    );
  }
}