import 'package:flutter/material.dart';
import '../../../backend/services/auth_service.dart';
import '../inicio.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {

  final AuthService _authService = AuthService();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFE8E5E1),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(

            child: Column(
              children: [

                Container(
                  width: screenWidth * 0.85,

                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: const Color(0xFF2E356D),

                    borderRadius:
                        BorderRadius.circular(18),

                    boxShadow: [
                      BoxShadow(
                        color:
                            Colors.black.withOpacity(0.25),

                        blurRadius: 8,

                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),

                  child: Column(
                    children: [

                      const Text(
                        "Registrate",

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 30),

                      // EMAIL
                      TextField(

                        controller: emailController,

                        decoration: InputDecoration(
                          filled: true,
                          fillColor:
                              const Color(0xFFE8E8EE),

                          hintText:
                              "Ingresa tu e-mail",

                          hintStyle: const TextStyle(
                            color: Color(0xFF9B9BB0),
                          ),

                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(10),

                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // NAME
                      TextField(

                        controller: nameController,

                        decoration: InputDecoration(
                          filled: true,
                          fillColor:
                              const Color(0xFFE8E8EE),

                          hintText: "Nombre",

                          hintStyle: const TextStyle(
                            color: Color(0xFF9B9BB0),
                          ),

                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(10),

                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // PASSWORD
                      TextField(

                        controller: passwordController,

                        obscureText: true,

                        decoration: InputDecoration(
                          filled: true,
                          fillColor:
                              const Color(0xFFE8E8EE),

                          hintText: "Contraseña",

                          hintStyle: const TextStyle(
                            color: Color(0xFF9B9BB0),
                          ),

                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(10),

                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                SizedBox(
                  width: screenWidth * 0.45,
                  height: 60,

                  child: ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF56B7B0),

                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                    ),

                    onPressed: () async {

                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();
                      final name = nameController.text.trim();

                      // Validación de campos vacíos
                      if (email.isEmpty || password.isEmpty || name.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content:
                                Text('Por favor completa todos los campos'),
                          ),
                        );
                        return;
                      }

                      // Validación de email
                      if (!email.contains('@') || !email.contains('.')) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content:
                                Text('Email inválido'),
                          ),
                        );
                        return;
                      }

                      // Validación de contraseña mínimo 6 caracteres
                      if (password.length < 6) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content:
                                Text('La contraseña debe tener mínimo 6 caracteres'),
                          ),
                        );
                        return;
                      }

                      final result =
                          await _authService.register(
                        email,
                        password,
                        name,
                      );

                      if (result['success']) {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const Inicio(),
                          ),
                        );

                      } else {

                        ScaffoldMessenger.of(context)
                            .showSnackBar(

                          SnackBar(
                            content:
                                Text(result['message']),
                          ),
                        );
                      }
                    },

                    child: const Text(
                      "Entrar",

                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E356D),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}