import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../colores/temas.dart';

class header extends StatefulWidget {
  const header({super.key});

  @override
  State<header> createState() => _headerState();
}

class _headerState extends State<header> {
  String _userName = 'Usuario';
  String _userInitial = 'U';
  String _horaActual = '';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _actualizarHora();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _actualizarHora());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _loadUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    
    if (user != null) {
      try {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        
        if (userDoc.exists) {
          final name = userDoc.get('name') as String? ?? 'Usuario';
          setState(() {
            _userName = name;
            _userInitial = name.isNotEmpty ? name[0].toUpperCase() : 'U';
          });
        }
      } catch (e) {
        debugPrint('Error loading user name: $e');
      }
    }
  }

  void _actualizarHora() {
    final now = DateTime.now().toLocal();
    final hora = now.hour.toString().padLeft(2, '0');
    final min = now.minute.toString().padLeft(2, '0');
    final ampm = now.hour < 12 ? 'AM' : 'PM';
    setState(() {
      _horaActual = '$hora:$min $ampm';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Opacity(
              opacity: 0.6,
              child: Text(
                _horaActual,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Hola, $_userName',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Container(
          width: 60,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            _userInitial,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}