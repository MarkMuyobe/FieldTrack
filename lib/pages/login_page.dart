import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth.dart';
import 'sign_up.dart'; // Import the SignUpPage

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Hmm? $errorMessage');
  }

  void _navigateToSignUpPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpPage()),
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        if (isLogin) {
          _navigateToSignUpPage();
        } else {
          setState(() {
            isLogin = !isLogin;
          });
        }
      },
      child: Text(isLogin ? 'Don\'t have an account? Sign up instead' : 'Already have an account? Login'),
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF4ECB71), // Adjust color as needed
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }

  InputDecoration _inputDecoration(String labelText, Icon icon) {
    const borderColor = Color(0xFF4ECB71);
    return InputDecoration(
      labelText: labelText,
      prefixIcon: icon,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
        borderSide: BorderSide(color: borderColor),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
        borderSide: BorderSide(color: borderColor),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
        borderSide: BorderSide(color: borderColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              const Text(
                'FIELDTRACK',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4ECB71),
                ),
              ),
              const SizedBox(height: 32.0),
              TextFormField(
                controller: _controllerEmail,
                decoration: _inputDecoration('Email', const Icon(Icons.email)),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _controllerPassword,
                obscureText: true,
                decoration: _inputDecoration('Password', const Icon(Icons.lock)),
              ),
              const SizedBox(height: 16.0),
              _errorMessage(),
              const SizedBox(height: 16.0),

              // Login Button with Gradient
              FractionallySizedBox(
                widthFactor: 0.5,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4ECB71), Color(0xFF276538)], // Gradient colors
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: ElevatedButton(
                    onPressed: () => {
                      if (isLogin) {
                        signInWithEmailAndPassword()
                      } else {
                        createUserWithEmailAndPassword()
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      backgroundColor: Colors.transparent, // Set background to transparent to see gradient
                      shadowColor: Colors.transparent, // Remove any button shadows
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24.0)),
                      ),
                    ),
                    child: Text(isLogin ? 'Login' : 'Sign Up'),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              _loginOrRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }
}
