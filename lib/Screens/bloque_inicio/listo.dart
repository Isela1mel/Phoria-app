import 'package:flutter/material.dart';
import 'package:phoria_app/iu/bloque_inicio/horarioheader.dart';
import 'package:phoria_app/iu/bloque_inicio/listo/listo_nombre.dart';
import 'package:phoria_app/iu/bloque_inicio/listo/nuevo_jugador.dart';
import 'package:phoria_app/iu/bloque_inicio/listo/tiempo_libre.dart';
import 'package:phoria_app/navegacion/boton_siguiente.dart';
import 'package:phoria_app/navegacion/main_navegacion.dart';
import '../../backend/services/user_service.dart';
import '../../backend/models/user_scheduel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Listo extends StatefulWidget {
  final String horaSuenio;
  final String horaLevantarse;

  const Listo({
    required this.horaSuenio,
    required this.horaLevantarse,
    super.key,
  });

  @override
  State<Listo> createState() => _ListoState();
}

class _ListoState extends State<Listo> {
  final _userService = UserService();
  bool _cargando = false;

  /// Guarda el horario fijo del usuario en Firestore (user_schedule)
  Future<void> _guardarHorario() async {
    setState(() => _cargando = true);
    
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) throw Exception('Usuario no autenticado');

      final suenioMinimo = int.tryParse(widget.horaSuenio) ?? 8;

      final schedule = UserSchedule(
        userId: uid,
        entradaClases: '', 
        salidaClases: '',
        traslado: 30,
        suenioMinimo: suenioMinimo,
        horaLevantarse: widget.horaLevantarse,
        createdAt: Timestamp.now(),
      );

      await _userService.guardarHorario(schedule);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Horario guardado exitosamente')),
      );

      // Redirigir al dashboard
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const MainNavegacion()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() => _cargando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              const HorarioHeader(currentStep: 0),
              const SizedBox(height: 200),

              const ListoNombre(
                // ───────── CAMBIAR NOMBRE AQUÍ ─────────
                userName: 'Melanie',
              ),

              const SizedBox(height: 50),

              const TiempoLibre(
                // ───────── CAMBIAR TIEMPO AQUÍ ─────────
                tiempoLibre: '2h 40m',
              ),
              const SizedBox(height: 50),
              const NuevoJugador(
                // ───────── CAMBIAR NIVEL AQUÍ ─────────
                level: 3,

                // ───────── CAMBIAR DESCRIPCIÓN AQUÍ ─────────
                description: '¡Nivel 3 alcanzado! Sigue así para desbloquear nuevas recompensas.',  
                // ───────── CAMBIAR PROGRESO AQUÍ (0.0 a 1.0) ─────────
                progress: 0.6,
              ),  

               const SizedBox(height: 50), 

              BotonSiguiente(
                text: _cargando ? 'Guardando...' : 'Confirmar',
                onTap: _cargando ? () {} : _guardarHorario,
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}