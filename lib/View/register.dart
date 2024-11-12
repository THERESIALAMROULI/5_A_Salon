import 'package:flutter/material.dart';
import 'package:tubesfix/View/login.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFE0AC53),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: usernameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: _inputDecoration("Username", Icons.person),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Username tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: emailController,
                          style: const TextStyle(color: Colors.white),
                          decoration: _inputDecoration("Email", Icons.email),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email tidak boleh kosong';
                            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              return 'Masukkan email yang valid';
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
                              return 'Password tidak boleh kosong';
                            } else if (value.length < 6) {
                              return 'Password harus minimal 6 karakter';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: confirmPasswordController,
                          style: const TextStyle(color: Colors.white),
                          decoration: _inputDecoration("Confirm Password", Icons.lock),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Konfirmasi password tidak boleh kosong';
                            } else if (value != passwordController.text) {
                              return 'Password tidak cocok';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Map<String, dynamic> formData = {};
                              formData['username'] = usernameController.text;
                              formData['password'] = passwordController.text;
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  Future.delayed(const Duration(seconds: 2), () {
                                    Navigator.pop(context); 
                                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext buildContext) => LoginView(data: formData,)));;
                                  });

                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15), 
                                    ),
                                    backgroundColor: Colors.transparent,
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: double.infinity,
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
                                                Icons.check_circle_outline,
                                                size: 60,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(16),
                                            child: const Text(
                                              "Account Created",
                                              style: TextStyle(
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
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            backgroundColor: const Color(0xFFE0AC53),
                          ),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: Color(0xFFF8F4E3)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginView()));
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Color(0xFFE0AC53)),
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
}
