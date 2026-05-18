import 'package:flutter/material.dart';

class CrearActividad extends StatefulWidget {
  const CrearActividad({super.key});

  @override
  State<CrearActividad> createState() => _CrearActividadState();
}

class _CrearActividadState extends State<CrearActividad> {
  late TextEditingController _nombreController;
  late TextEditingController _horaInicioController;
  late TextEditingController _horaFinController;
  bool _guardando = false;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController();
    _horaInicioController = TextEditingController();
    _horaFinController = TextEditingController();
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _horaInicioController.dispose();
    _horaFinController.dispose();
    super.dispose();
  }

  /// Convierte TimeOfDay a formato 24h string "HH:MM"
  String _formatearHora(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  /// Abre selector de hora para inicio
  Future<void> _seleccionarHoraInicio() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _horaInicioController.text = _formatearHora(picked);
      });
    }
  }

  /// Abre selector de hora para fin
  Future<void> _seleccionarHoraFin() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _horaFinController.text = _formatearHora(picked);
      });
    }
  }

  /// Guarda la actividad y vuelve
  void _guardarActividad() {
    if (_nombreController.text.isEmpty ||
        _horaInicioController.text.isEmpty ||
        _horaFinController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor completa todos los campos')),
      );
      return;
    }

    setState(() => _guardando = true);

    // Simular delay de guardado
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.pop(
        context,
        {
          'nombre': _nombreController.text,
          'horaInicio': _horaInicioController.text,
          'horaFin': _horaFinController.text,
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Nueva Actividad',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ───────── NOMBRE ACTIVIDAD ─────────
              Text(
                'Nombre de la actividad',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _nombreController,
                decoration: InputDecoration(
                  hintText: 'Ej: Clases, Estudiar Java, Gym',
                  prefixIcon: const Icon(Icons.edit),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // ───────── HORA INICIO ─────────
              Text(
                'Hora de inicio',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _horaInicioController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Selecciona la hora',
                  prefixIcon: const Icon(Icons.schedule),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onTap: _seleccionarHoraInicio,
              ),
              const SizedBox(height: 30),

              // ───────── HORA FIN ─────────
              Text(
                'Hora de finalización',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _horaFinController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Selecciona la hora',
                  prefixIcon: const Icon(Icons.schedule),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onTap: _seleccionarHoraFin,
              ),
              const SizedBox(height: 50),

              // ───────── BOTÓN GUARDAR ─────────
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _guardando ? null : _guardarActividad,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D3561),
                    disabledBackgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    _guardando ? 'Guardando...' : 'Guardar Actividad',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
