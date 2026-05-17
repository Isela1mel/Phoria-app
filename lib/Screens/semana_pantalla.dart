import 'package:flutter/material.dart';
import 'package:phoria_app/iu/semana/Productividad.dart';
import 'package:phoria_app/iu/semana/metas_cumplidas_semana.dart';
import 'package:phoria_app/iu/semana/patrones.dart';
import 'package:phoria_app/iu/semana/semana_header.dart';


class SemanaPantalla extends StatelessWidget {
  const SemanaPantalla({super.key});

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
              SizedBox(height: 40),
              HeaderSemana(
                  // ───────── CAMBIAR DATOS AQUÍ ─────────
                  tareasCompletadas: 3,
                  tareasTotales: 5,
                  semana: 15,
                ),
              SizedBox(height: 30),
              MetasCumplidasSemana(

                // ───────── CAMBIAR DATOS AQUÍ ─────────
                metasCumplidas: 74,
                mejoraSemanal: 12,

                // ───────── VALORES ENTRE 0.0 y 1.0 ─────────
                concentracion: 0.75,
                constancia: 0.68,
                bienestar: 0.64,
              ),
              SizedBox(height: 30),
              Productividad(
                // ───────── CAMBIAR PRODUCTIVIDAD ─────────
                valores: [
                  0.4, // lunes
                  0.9, // martes
                  0.7, // miercoles
                  0.2, // jueves
                  0.9, // viernes
                  0.5, // sabado
                  0.1, // domingo
                ],
              ),
              SizedBox(height: 30),
              Patrones(),
            ],
          ),
        ),
      ),
    );
  }
}