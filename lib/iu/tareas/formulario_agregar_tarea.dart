import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../backend/models/task_model.dart';
import '../../backend/services/task_service.dart';

class FormularioAgregarTarea extends StatefulWidget {
  const FormularioAgregarTarea({super.key});

  @override
  State<FormularioAgregarTarea> createState() => _FormularioAgregarTareaState();
}

class _FormularioAgregarTareaState extends State<FormularioAgregarTarea> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _tiempoController = TextEditingController();

  String _dificultadSeleccionada = 'facil';
  DateTime? _fechaLimite;
  int _xpAsignado = 50; // Por defecto para 'facil'

  // Mapa de dificultades a XP
  final Map<String, int> _xpPorDificultad = {
    'facil': 50,
    'medio': 100,
    'dificil': 150,
  };

  @override
  void dispose() {
    _tituloController.dispose();
    _tiempoController.dispose();
    super.dispose();
  }

  // Actualizar XP según dificultad
  void _actualizarXp(String dificultad) {
    setState(() {
      _dificultadSeleccionada = dificultad;
      _xpAsignado = _xpPorDificultad[dificultad] ?? 10;
    });
  }

  // Seleccionar fecha
  Future<void> _seleccionarFecha() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => _fechaLimite = picked);
    }
  }

  // Guardar tarea
  Future<void> _guardarTarea() async {
    if (!_formKey.currentState!.validate() || _fechaLimite == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor completa todos los campos')),
      );
      return;
    }

    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final tarea = TaskModel(
        titulo: _tituloController.text.trim(),
        dificultad: _dificultadSeleccionada,
        xpReward: _xpAsignado,
        completada: false,
        userId: userId,
        fecha: _fechaLimite!,
      );

      await TaskService().crearTarea(tarea);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✓ Tarea guardada exitosamente')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Nueva Tarea'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ────── TÍTULO ──────
              const Text(
                'Título de la Tarea',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _tituloController,
                decoration: InputDecoration(
                  hintText: 'Ej: Hacer tarea de matemáticas',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.task),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor ingresa un título';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // ────── TIEMPO ESTIMADO ──────
              const Text(
                'Tiempo Estimado (en minutos)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _tiempoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Ej: 30, 60, 120',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.timer),
                  suffixText: 'min',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor ingresa el tiempo estimado';
                  }
                  if (int.tryParse(value!) == null) {
                    return 'Por favor ingresa un número válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // ────── DIFICULTAD ──────
              const Text(
                'Nivel de Dificultad',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: _dificultadSeleccionada,
                  isExpanded: true,
                  underline: const SizedBox(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      _actualizarXp(newValue);
                    }
                  },
                  items: <String>['facil', 'medio', 'dificil']
                      .map<DropdownMenuItem<String>>((String value) {
                    final labels = {
                      'facil': '🟢 Fácil',
                      'medio': '🟡 Medio',
                      'dificil': '🔴 Difícil',
                    };
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(labels[value] ?? value),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 12),

              // ────── XP ASIGNADO ──────
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 24),
                    const SizedBox(width: 12),
                    Text(
                      'Recompensa: $_xpAsignado XP',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // ────── FECHA LÍMITE ──────
              const Text(
                'Fecha Límite',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _seleccionarFecha,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.grey),
                      const SizedBox(width: 12),
                      Text(
                        _fechaLimite == null
                            ? 'Selecciona una fecha'
                            : '${_fechaLimite!.day}/${_fechaLimite!.month}/${_fechaLimite!.year}',
                        style: TextStyle(
                          fontSize: 14,
                          color: _fechaLimite == null
                              ? Colors.grey
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // ────── BOTONES ──────
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _guardarTarea,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Guardar Tarea',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
