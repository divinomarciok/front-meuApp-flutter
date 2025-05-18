import 'package:flutter/material.dart';
import 'package:front_leilaorv/data/providers/auth.provider.dart';
import 'package:front_leilaorv/data/providers/product.provider.dart';
import 'package:front_leilaorv/service/service.token.storage.dart';
import 'package:provider/provider.dart';
import '../service/services.login.dart'; // Importe seu service

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _isLoading = false;
  String? _error;

  final LoginService _loginService = LoginService(); // Instancie seu service

  void _login() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final token = await _loginService.returnLogin(
        _userController.text,
        _passController.text,
      );
      if (token != '') {
        await TokenStorageService().saveToken(token);

        Provider.of<AuthProvider>(context, listen: false).setToken(token);

        Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() {
          _error = "Usuário ou senha inválidos";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = "Erro ao conectar. Tente novamente.";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: screenSize.width < 400 ? double.infinity : 400,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.lock, size: 64, color: Colors.lightGreen),
                const SizedBox(height: 16),
                const Text(
                  "Bem-vindo ao AUCTION RIO VERDE - GO",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightGreen,
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _userController,
                  decoration: InputDecoration(
                    labelText: "Usuário",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      _error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Entrar",
                            style: TextStyle(fontSize: 16),
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