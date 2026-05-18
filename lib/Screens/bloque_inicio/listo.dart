import 'package:flutter/material.dart';
import 'package:phoria_app/iu/bloque_inicio/horarioheader.dart';
import 'package:phoria_app/iu/bloque_inicio/listo/listo_nombre.dart';
import 'package:phoria_app/iu/bloque_inicio/listo/nuevo_jugador.dart';
import 'package:phoria_app/iu/bloque_inicio/listo/tiempo_libre.dart';
import '../../backend/services/tiempo_servicio.dart';
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
  final _timeService = TimeService();
  bool _cargando = false;

  int? _minutosLibres;
  bool _loadingTiempo = true;

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
        SnackBar(content: Text('Error: [31m${e.toString()}[0m')),
      );
    } finally {
      setState(() => _cargando = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _calcularTiempoLibre();
  }

  Future<void> _calcularTiempoLibre() async {
    setState(() { _loadingTiempo = true; });
    // Leer horario y actividades
    final horario = await _userService.leerHorario();
    final actividades = await _userService.leerActividades();

    // Convertir horaLevantarse y sueño a minutos
    int wakeUp = _parseHoraToMin(horario?.horaLevantarse ?? '07:00');
    int sleep = wakeUp + (horario?.suenioMinimo ?? 8) * 60;
    if (sleep >= 1440) sleep -= 1440;

    // Sumar duración de actividades fijas (traslado, clases, bloques)
    List<int> actividadesFijas = [];
    if (horario != null) {
      actividadesFijas.add(horario.traslado);
      // Si hay clases
      if (horario.entradaClases.isNotEmpty && horario.salidaClases.isNotEmpty) {
        int entrada = _parseHoraToMin(horario.entradaClases);
        int salida = _parseHoraToMin(horario.salidaClases);
        int duracion = salida >= entrada ? salida - entrada : (1440 - entrada) + salida;
        actividadesFijas.add(duracion);
      }
    }
    // Sumar bloques de actividades
    for (var act in actividades) {
      int inicio = _parseHoraToMin(act.horaInicio);
      int fin = _parseHoraToMin(act.horaFin);
      int dur = fin >= inicio ? fin - inicio : (1440 - inicio) + fin;
      actividadesFijas.add(dur);
    }

    int libres = _timeService.calcularTiempoLibre(
      wakeUpMinutes: wakeUp,
      sleepMinutes: sleep,
      fixedActivities: actividadesFijas,
    );
    setState(() {
      _minutosLibres = libres;
      _loadingTiempo = false;
    });
  }

  int _parseHoraToMin(String hora) {
    final partes = hora.split(':');
    int h = int.tryParse(partes[0]) ?? 0;
    int m = int.tryParse(partes.length > 1 ? partes[1] : '0') ?? 0;
    return h * 60 + m;
  }

  String _formatearMinutos(int minutos) {
    int h = minutos ~/ 60;
    int m = minutos % 60;
    if (h > 0 && m > 0) return '${h}h ${m}m';
    if (h > 0) return '${h}h';
    return '${m}m';
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
              const ListoNombre(userName: 'Melanie'),
              const SizedBox(height: 50),
              _loadingTiempo
                  ? const CircularProgressIndicator()
                  : TiempoLibre(
                      tiempoLibre: _formatearMinutos(_minutosLibres ?? 0),
                    ),
              const SizedBox(height: 50),
              const NuevoJugador(
                level: 3,
                description: '¡Nivel 3 alcanzado! Sigue así para desbloquear nuevas recompensas.',
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
