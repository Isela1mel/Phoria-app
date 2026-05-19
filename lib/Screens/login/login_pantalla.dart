import 'package:flutter/material.dart';
import 'registro_pantalla.dart';
import '../inicio.dart';
import '../../../backend/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final AuthService _authService = AuthService();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFE8E5E1),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(

            child: Column(
              children: [

                // Mascota arriba
                Image.asset(
                  'imagenes/Mascota_LR.png',
                  width: screenWidth * 0.65,
                  height: screenHeight * 0.35,
                  fit: BoxFit.contain,
                ),

                SizedBox(height: screenHeight * 0.02),

                // Contenedor con inputs
                Container(
                  width: screenWidth * 0.85,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E356D),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      const Center(
                        child: Text(
                          "Bienvenido de nuevo",
                          textAlign: TextAlign.center,

                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // EMAIL
                      TextField(

                        controller: emailController,

                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFE8E8EE),

                          hintText: "Ingresa tu e-mail",

                          hintStyle: const TextStyle(
                            color: Color(0xFF9B9BB0),
                          ),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
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
                          fillColor: const Color(0xFFE8E8EE),

                          hintText: "Contraseña",

                          hintStyle: const TextStyle(
                            color: Color(0xFF9B9BB0),
                          ),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      Align(
                        alignment: Alignment.centerRight,

                        child: TextButton(

                          onPressed: () {

                            Navigator.push(
                              context,

                              MaterialPageRoute(
                                builder: (_) =>
                                    const RegisterScreen(),
                              ),
                            );
                          },

                          child: const Text(
                            "Registrarse",

                            style: TextStyle(
                              color: Colors.white,
                            ),
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

                      final result =
                          await _authService.login(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );

                      if (result['success']) {

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const Inicio(),
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