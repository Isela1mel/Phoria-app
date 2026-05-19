import 'package:flutter/material.dart';
import '../iu/inicio/header.dart';
import '../iu/inicio/frase.dart';
import '../iu/inicio/stats.dart';
import '../iu/inicio/tiempo.dart';
import '../iu/inicio/bloques.dart';
import '../navegacion/boton_bloque.dart';

// CAMBIO: Inicio ahora carga las actividades del backend y las pasa a Bloques
import '../backend/services/user_service.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});
  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  final _userService = UserService();

  Future<List<Map<String, dynamic>>> _cargarActividades() async {
    final acts = await _userService.leerActividades();
    // Mapea a los campos que espera Bloques
    return acts.map((a) => {
      'title': a.nombre,
      'time': '${a.horaInicio} - ${a.horaFin}',
      'tag': a.userId.isNotEmpty ? 'Hoy' : '',
      'isFixed': false, // Puedes ajustar según tu lógica
    }).toList();
  }

  // CAMBIO: Ahora descuenta tanto los bloques de actividades como las horas mínimas de sueño del usuario
  // para mostrar el tiempo libre real del día.
  Future<Map<String, dynamic>> _cargarTiempoLibre() async {
    // 1. Lee el horario del usuario (para obtener las horas mínimas de sueño)
    final horario = await _userService.leerHorario();
    if (horario == null) {
      // Si no hay horario, retorna valores por defecto
      return {'freeTime': '--', 'percentage': 0};
    }

    // 2. Lee todas las actividades del usuario
    final actividades = await _userService.leerActividades();

    // 3. Convierte horaInicio y horaFin a minutos y suma la duración de cada bloque
    int _horaStringAMinutos(String hora) {
      final partes = hora.split(':');
      return int.parse(partes[0]) * 60 + int.parse(partes[1]);
    }

    int totalOcupado = actividades.fold(0, (sum, a) {
      final inicio = _horaStringAMinutos(a.horaInicio);
      final fin = _horaStringAMinutos(a.horaFin);
      // Si la actividad cruza medianoche
      if (fin < inicio) {
        return sum + (1440 - inicio) + fin;
      } else {
        return sum + (fin - inicio);
      }
    });

    // 4. Calcula los minutos de sueño requeridos
    final minutosSueno = (horario.suenioMinimo) * 60;

    // 5. Calcula el tiempo libre restando bloques y sueño al total del día
    final libres = 1440 - totalOcupado - minutosSueno;
    final porcentaje = ((libres / 1440) * 100).round();
    final horas = libres ~/ 60;
    final mins = libres % 60;
    final freeTime = horas > 0 ? '${horas}h ${mins}m' : '${mins}m';

    // Devuelve el tiempo libre y el porcentaje
    return {'freeTime': freeTime, 'percentage': porcentaje};
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
              const header(),
              const SizedBox(height: 30),
              const Frase(),
              const SizedBox(height: 20),
              const Stats(),
              const SizedBox(height: 20),
              // FutureBuilder para mostrar el tiempo libre calculado dinámicamente
              // Utiliza la función _cargarTiempoLibre definida como método de la clase (fuera de build)
              FutureBuilder<Map<String, dynamic>>(
                future: _cargarTiempoLibre(), // Llama a la función que obtiene el tiempo libre y porcentaje
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Muestra un indicador de carga mientras se obtienen los datos
                    return const Center(child: CircularProgressIndicator());
                  }
                  // Si hay datos, los usa; si no, muestra valores por defecto
                  final data = snapshot.data ?? {'freeTime': '--', 'percentage': 0};
                  return Tiempo(
                    freeTime: data['freeTime'] ?? '--',
                    percentage: data['percentage'] ?? 0,
                  );
                },
              ),
              const SizedBox(height: 20),

              // CAMBIO: ahora se usa FutureBuilder para mostrar actividades reales
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _cargarActividades(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final acts = snapshot.data ?? [];
                  return Bloques(actividades: acts);
                },
              ),

              const SizedBox(height: 20),
              const Boton(),
            ],
          ),
        ),
      ),
    );
  }
}