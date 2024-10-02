import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:mad_demo/model/models.dart';
import 'package:provider/provider.dart';
import '../model/user_provider.dart';
import 'sign_up.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLoading = false;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    if (_controllerEmail.text.isEmpty || _controllerPassword.text.isEmpty) {
      setState(() {
        errorMessage = 'Please fill in all fields';
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      await Provider.of<UserProvider>(context, listen: false).signIn(
        _controllerEmail.text,
        _controllerPassword.text,
      );
      Navigator.pushReplacementNamed(context, '/homepage');
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Hmm? $errorMessage');
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: _navigateToSignUpPage,
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF4ECB71),
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: const Text('Don\'t have an account? Sign up'),

    );
  }

  @override
  Widget build(BuildContext context) {
    const borderColor = Color(0xFF4ECB71); // Consistent border color

    // Create a border style for input fields
    final borderStyle = OutlineInputBorder(
      borderSide: BorderSide(color: borderColor, width: 1.5),
      borderRadius: BorderRadius.circular(20),
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Prevent back button from appearing
        title: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: const GradientText(
            'FIELDTRACK',
            gradient: LinearGradient(
              colors: [Color(0xFF4ECB71), Color(0xFF276538)],
            ),
            fontSize: 40,
            fontFamily: 'Amuse-Bouche',
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
      ),
      body: Center( // Center the form vertically
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 32.0),
              // Email field
              TextFormField(
                controller: _controllerEmail,
                decoration: inputDecoration('Email', const Icon(Icons.email)),
                keyboardType: TextInputType.emailAddress,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              const SizedBox(height: 20.0),
              // Password field with visibility toggle
              TextFormField(
                controller: _controllerPassword,
                obscureText: true,
                decoration: inputDecoration('Password', const Icon(Icons.lock)),
              ),
              const SizedBox(height: 10.0), // Reduced space
              _errorMessage(),
              const SizedBox(height: 5.0),
              // Login Button with Gradient
              // Login Button with Gradient
              Container(
                padding: const EdgeInsets.all(5.0), // Add padding around the button
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF4ECB71), // #4ECB71 (light green)
                      Color(0xFF276538), // #276538 (dark green)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  child: ElevatedButton(
                    onPressed: isLoading ? null : signInWithEmailAndPassword,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      backgroundColor: Colors.transparent, // Set background to transparent to see gradient
                      shadowColor: Colors.transparent, // Remove any button shadows
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24.0)),
                      ),
                    ),
                    child: isLoading 
                      ? CircularProgressIndicator(color: Colors.white)
                      : const Text('Login'),
                  ),
                ),
              ),
              const SizedBox(height: 5.0), // Reduced space
              // Navigation to Sign Up
              _loginOrRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }
}
