import 'package:flutter/material.dart';
import 'package:tubesfix/View/home.dart';
import 'package:tubesfix/View/register.dart';
import 'package:tubesfix/client/PelangganClient.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginView extends StatefulWidget {
  final Map? data;

  const LoginView({super.key, this.data});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 100),
                        const Text(
                          "ATMA BARBER",
                          style: TextStyle(
                            fontFamily: 'Mixages', fontSize: 28, fontWeight: FontWeight.w700,
                            color: Color(0xFFE0AC53),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 20),
                        _inputField(),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {

                            if (_formKey.currentState!.validate()) {
                              _login();
                            }

                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            backgroundColor: const Color(0xFFE0AC53),
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontFamily: 'Inter', fontSize: 20, fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "don't have an account? ",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w400
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const RegisterView()),
                            );
                          },
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                              color: Color(0xFFE0AC53),
                              fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w400
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => HomeView(data: {'username': 'Guest'}),
                          ),
                        );
                      },
                      child: const Text(
                        "Enter as guest",
                        style: TextStyle(
                          color: Color(0xFFE0AC53),
                          fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField() {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: usernameController,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration("Username", Icons.person),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Username masih kosong';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: passwordController,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration("Password", Icons.lock),
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password masih kosong';
            }
            return null;
          },
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {
              // forgot password nanti disini
            },
            child: const Text(
              "I Forgot My Password",
              style: TextStyle(color: Color.fromRGBO(248, 244, 227, 1), fontFamily: 'Inter', fontSize: 10, fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.white.withOpacity(0.75)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
      fillColor: const Color.fromRGBO(248, 244, 227, 1).withOpacity(0.1),
      filled: true,
      prefixIcon: Icon(icon, color: Colors.white.withOpacity(0.75)),
    );
  }
  void _showErrorDialog(String message) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context);
      });

      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 80,
                decoration: const BoxDecoration(
                  color: Color(0xFFE0AC53),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.cancel_outlined,
                    size: 60,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  message,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

  void _login() async {
    final pelangganClient = PelangganClient();

    try {
      final response = await pelangganClient.login(
        usernameController.text,  
        passwordController.text,
      );

      if (response.isNotEmpty && response.containsKey('token')) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HomeView(data: response),  
          ),
        );
      } else {
        _showErrorDialog('Invalid username or password');
      }
    } catch (e) {
      print("Error: $e");
      _showErrorDialog('Failed to connect to the server');
    }
  }

  void pushRegister(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterView()));
  }
}
