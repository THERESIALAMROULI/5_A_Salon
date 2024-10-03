import 'package:flutter/material.dart';
import 'package:tubesfix/View/home.dart';
import 'package:tubesfix/View/register.dart';

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
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _inputField(),
                _forgotPassword(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputField() {
    Map? dataForm = widget.data;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: usernameController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Username",
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.75)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none
            ),
            fillColor: const Color.fromRGBO(248, 244, 227, 1).withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.person),
          ),
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
          decoration: InputDecoration(
            hintText: "Password",
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.75)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: Color.fromRGBO(248, 244, 227, 1).withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.password),
          ),
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password masih kosong';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) { 
              if (dataForm != null) {
                if (dataForm['username'] == usernameController.text &&
                    dataForm['password'] == passwordController.text) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeView(),));
                } else {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Username Atau Password Salah"),
                      content: const Text("Silakan coba lagi."),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              } else {
                // Jika dataForm null
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Akun Belum Dibuat!"),
                    content: TextButton(
                      onPressed: () => pushRegister(context),
                      child: const Text('Daftar Disini !!'),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                );
              }
            }
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Color(0xFFF8F4E3),
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20, color: Color.fromRGBO(0, 0, 0, 1)),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterView(),));
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Color.fromRGBO(0, 0, 0, 1),
            side: const BorderSide(color: Color(0xFFF8F4E3)),
          ),
          child: const Text(
            "Register",
            style: TextStyle(fontSize: 20, color: Color(0xFFF8F4E3)),
          ),
        ),
      ],
    );
  }

  Widget _forgotPassword(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: const Text("Forgot password?",
        style: TextStyle(color: Color.fromRGBO(248, 244, 227, 1)),
      ),
    );
  }

  void pushRegister(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterView(),));
  }
}
