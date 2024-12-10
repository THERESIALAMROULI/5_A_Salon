import 'package:flutter/material.dart';
import 'package:tubesfix/View/login.dart';
import 'package:tubesfix/client/PelangganClient.dart';
import 'package:tubesfix/entity/Pelanggan.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController namaController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController noTeleponController = TextEditingController();
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
                            fontFamily: 'Mixages', fontSize: 28, fontWeight: FontWeight.w700,
                            color: Color(0xFFE0AC53),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: namaController,
                          style: const TextStyle(color: Colors.white),
                          decoration: _inputDecoration("Name", Icons.person),
                          validator: (value) {
                            if (value == null || value.isEmpty) {

                              return 'Name must not empty';

                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: usernameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: _inputDecoration("Username", Icons.people_alt),
                          validator: (value) {
                            if (value == null || value.isEmpty) {

                              return 'Username must not empty';

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

                              return 'Email must not empty';
                            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              return 'Use a valid email!';

                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: noTeleponController,
                          style: const TextStyle(color: Colors.white),
                          decoration: _inputDecoration("Phone Number", Icons.phone),
                          validator: (value) {
                            if (value == null || value.isEmpty) {

                              return 'Phone Number must not empty';

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

                              return 'Password must not empty';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 character';

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

                              return 'Password confiration must not be empty';
                            } else if (value != passwordController.text) {
                              return 'Invalid passsword';

                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {

                              Map<String, dynamic> formData = {};
                              formData['name'] = namaController.text;
                              formData['username'] = usernameController.text;
                              formData['password'] = passwordController.text;
                              formData['email'] = emailController.text;
                              formData['phone'] = noTeleponController.text;
                              
                              final pelanggan = Pelanggan(
                                  id: 0,
                                  nama: namaController.text,
                                  username: usernameController.text,
                                  email: emailController.text,
                                  telepon: noTeleponController.text,
                                  password: passwordController.text,
                                );

                              final response = await PelangganClient.create(pelanggan);
                              if (response.statusCode == 201) {
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
                              } else {
                                  print('Gagal: ${response.body}');
                              }
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
                            style: TextStyle(fontFamily: 'Inter', fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
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
                      style: TextStyle(color: Color(0xFFF8F4E3), fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginView()));
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Color(0xFFE0AC53), fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      )));
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

