import 'package:flutter/material.dart';
import 'package:phoria_app/Screens/bloque_inicio/agregar_descanso.dart';
import 'package:phoria_app/Screens/bloque_inicio/crear_actividad.dart';
import 'package:phoria_app/backend/services/user_service.dart';
import '../../iu/bloque_inicio/agregar_actividad/preguntahorario.dart';
import '../../iu/bloque_inicio/agregar_actividad/agergaractividad.dart';
import '../../iu/bloque_inicio/horarioheader.dart';
import '../../navegacion/boton_siguiente.dart';


class AgregarActividad extends StatefulWidget {
  const AgregarActividad({super.key});
  @override
  State<AgregarActividad> createState() => _AgregarActividadState();
}

class _AgregarActividadState extends State<AgregarActividad> {
  final List<Map<String, String>> _actividades = [];
  bool _cargando = true;
  final _userService = UserService();

  @override
  void initState() {
    super.initState();
    _cargarActividadesGuardadas();
  }

  // Carga actividades guardadas de Firestore
  Future<void> _cargarActividadesGuardadas() async {
    setState(() => _cargando = true);
    final acts = await _userService.leerActividades();
    setState(() {
      _actividades
        ..clear()
        ..addAll(acts.map((a) => {
          'nombre': a.nombre,
          'horaInicio': a.horaInicio,
          'horaFin': a.horaFin,
        }));
      _cargando = false;
    });
  }

  // Abre formulario y agrega si no hay traslape
  Future<void> _abrirCrearActividad() async {
    final res = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(builder: (_) => const CrearActividad()),
    );
    if (res != null) {
      int ni = _parseHoraToMin(res['horaInicio']!);
      int nf = _parseHoraToMin(res['horaFin']!);
      bool traslape = _actividades.any((a) {
        int ai = _parseHoraToMin(a['horaInicio']!);
        int af = _parseHoraToMin(a['horaFin']!);
        return (ni < af && nf > ai);
      });
      if (traslape) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Esa hora ya está ocupada.')),
        );
        return;
      }
      setState(() => _actividades.add(res));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Actividad "${res['nombre']}" agregada')),
      );
    }
  }

  // Convierte "HH:mm" a minutos
  int _parseHoraToMin(String h) {
    final p = h.split(':');
    return (int.tryParse(p[0]) ?? 0) * 60 + (int.tryParse(p.length > 1 ? p[1] : '0') ?? 0);
  }

  void _eliminarActividad(int i) => setState(() => _actividades.removeAt(i));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: SafeArea(
        child: _cargando
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    HorarioHeader(currentStep: 0),
                    const SizedBox(height: 30),
                    PreguntaHorario(),
                    const SizedBox(height: 30),
                    if (_actividades.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Actividades agregadas', style: Theme.of(context).textTheme.headlineSmall),
                          const SizedBox(height: 12),
                          ..._actividades.asMap().entries.map((e) => Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: const Color(0xFF72C8C7), width: 2),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(e.value['nombre']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                                          const SizedBox(height: 4),
                                          Text('${e.value['horaInicio']} - ${e.value['horaFin']}', style: const TextStyle(fontSize: 14, color: Color(0xFF72C8C7), fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.close, color: Colors.red),
                                      onPressed: () => _eliminarActividad(e.key),
                                    ),
                                  ],
                                ),
                              )),
                          const SizedBox(height: 20),
                        ],
                      ),
                    Agergaractividad(onTap: _abrirCrearActividad),
                    const SizedBox(height: 30),
                    BotonSiguiente(
                      text: 'Siguiente',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AgregarDescanso(actividades: _actividades),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
