import 'package:flutter/material.dart';
import 'package:phoria_app/Screens/bloque_inicio/listo.dart';
import 'package:phoria_app/iu/bloque_inicio/descanso/monitoreo.dart';
import 'package:phoria_app/navegacion/boton_siguiente.dart';
import '../../iu/bloque_inicio/descanso/tu_descanso.dart';
import '../../iu/bloque_inicio/horarioheader.dart';
import '../../backend/models/activity_block_model.dart';
import '../../backend/services/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AgregarDescanso extends StatefulWidget {
  final List<Map<String, String>> actividades;

  const AgregarDescanso({
    required this.actividades,
    super.key,
  });

  @override
  State<AgregarDescanso> createState() => _AgregarDescansoState();
}

class _AgregarDescansoState extends State<AgregarDescanso> {
  late TextEditingController _horaSuenoController;
  late TextEditingController _horaLevantarseController;
  bool _guardando = false;
  final _userService = UserService();

  @override
  void initState() {
    super.initState();
    _horaSuenoController = TextEditingController(text: '8');
    _horaLevantarseController = TextEditingController(text: '06:00');
  }

  /// Convierte TimeOfDay a formato 24h string "HH:MM"
  String _formatearHora(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  /// Abre selector de hora para levantarse
  Future<void> _seleccionarHoraLevantarse() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _horaLevantarseController.text = _formatearHora(picked);
      });
    }
  }

  /// Abre selector de horas de sueño
  Future<void> _seleccionarHorasSueno() async {
    showDialog(
      context: context,
      builder: (context) {
        String horas = _horaSuenoController.text;
        return AlertDialog(
          title: const Text('Horas de sueño'),
          content: TextField(
            keyboardType: TextInputType.number,
            controller: TextEditingController(text: horas),
            decoration: const InputDecoration(hintText: 'Ej: 7, 8, 9'),
            onChanged: (value) => horas = value,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() => _horaSuenoController.text = horas);
                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _horaSuenoController.dispose();
    _horaLevantarseController.dispose();
    super.dispose();
  }

  /// Guarda actividades usando ActivityBlockModel y UserService
  /// Si el usuario crea 2 actividades, se guardan 2 documentos en usuarios/{uid}/activity_blocks/
  Future<void> _guardarActividades() async {
    setState(() => _guardando = true);

    try {
      // Convertir Map<String,String> a ActivityBlockModel
      final actividadesModelos = widget.actividades.map((act) {
        return ActivityBlockModel(
          userId: '', // Se asigna en el servicio desde el usuario autenticado
          nombre: act['nombre']!,
          horaInicio: act['horaInicio']!,
          horaFin: act['horaFin']!,
          createdAt: Timestamp.now(),
        );
      }).toList();

      // Guardar todas las actividades usando el servicio
      await _userService.guardarMultiplesActividades(actividadesModelos);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Actividades guardadas exitosamente')),
      );

      // Ir a siguiente pantalla
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Listo(
              horaSuenio: _horaSuenoController.text,
              horaLevantarse: _horaLevantarseController.text,
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar: ${e.toString()}')),
      );
    } finally {
      setState(() => _guardando = false);
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
              SizedBox(height: 20),
              HorarioHeader(currentStep: 0),
              SizedBox(height: 250),
   
              TuDescanso(),
              SizedBox(height: 30),
  
              // ───────── HORA LEVANTARSE ─────────
              Text(
                'Hora de levantarse',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _horaLevantarseController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Selecciona la hora',
                  prefixIcon: const Icon(Icons.schedule),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onTap: _seleccionarHoraLevantarse,
              ),
              
              const SizedBox(height: 30),
              
              // ───────── HORAS DE SUEÑO ─────────
              Text(
                'Horas mínimas de sueño',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _horaSuenoController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Selecciona horas',
                  prefixIcon: const Icon(Icons.schedule),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onTap: _seleccionarHorasSueno,
              ),
              
              SizedBox(height: 40),

              Monitoreo(
                        // ───────── Apps actuales ─────────
                        apps: const [
                          'TikTok',
                          'Instagram',
                          'YouTube',
                        ],
                      // ───────── Botón agregar ─────────
                      onAdd: () {
                        // AQUÍ abres selector de apps
                      },
                      // ───────── Eliminar app ─────────
                      onRemove: (app) {
                        // AQUÍ eliminas app
                        print(app);
                      },
                    ),
                    SizedBox(height: 20),
                
                BotonSiguiente(
                text: _guardando ? 'Guardando...' : 'Siguiente',
                onTap: _guardando ? () {} : _guardarActividades,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
                      
                     