import 'package:flutter/material.dart';
import 'package:tubesfix/View/home.dart';
import 'package:tubesfix/View/register.dart';
import 'package:tubesfix/component/form_component.dart';

class LoginView extends StatefulWidget {
  final Map? data;

  const LoginView({super.key, this.data});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _inputField(context),
              _forgotPassword(context),
            ],
          ),
        ),
      ),
    );
  }


  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              hintText: "Username",
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.75)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none
                  
              ),
              fillColor: const Color.fromRGBO(248,244,227,1).withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.person)),
        ),
        const SizedBox(height: 10),
        TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(

            hintText: "Password",
            
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.75)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: Color.fromRGBO(248,244,227,1).withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.password),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 10),
        ElevatedButton(//login
          onPressed: () {
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Color(0xFFF8F4E3),
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20,color:  Color.fromRGBO(0, 0, 0, 1)),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(//regis
          onPressed: () {
             Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterView(),),);
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Color.fromRGBO(0, 0, 0, 1),
            side: BorderSide(color:  Color(0xFFF8F4E3))
          ),
          child: const Text(
            "Register",
            style: TextStyle(fontSize: 20,color: Color(0xFFF8F4E3)),
            
          ),
        )
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {},
      child: const Text("Forgot password?",
        style: TextStyle(color: Color.fromRGBO(248,244,227,1)),
      ),
    );
  }

 
}