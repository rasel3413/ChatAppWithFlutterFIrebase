// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chatapp/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/my_button.dart';
import '../components/my_text_field.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passWordcontroller = TextEditingController();
  final confirmPassWordcontroller = TextEditingController();

  void signUp() async {
    if (passWordcontroller.text != confirmPassWordcontroller.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Password do not match")));
      return;
    }
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signUpWithEmailandPassword(
          emailController.text, passWordcontroller.text);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.message,
                  size: 100,
                  color: Colors.grey[800],
                ),
                SizedBox(height: 50),
                Text(
                  "Let's create an account for you",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 50),
                MyTextField(
                    controller: emailController,
                    hintText: "Email",
                    obsecureText: false),
                SizedBox(height: 10),
                MyTextField(
                    controller: passWordcontroller,
                    hintText: "Password",
                    obsecureText: true),
                SizedBox(height: 10),
                MyTextField(
                    controller: confirmPassWordcontroller,
                    hintText: "Confirm Password",
                    obsecureText: true),
                SizedBox(height: 25),
                MyButton(onTap: signUp, text: "Sign Up"),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already a member?"),
                    SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Login now",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
