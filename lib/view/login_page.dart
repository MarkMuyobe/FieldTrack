import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mad_demo/model/models.dart';
import 'package:provider/provider.dart';
import '../controller/user_provider.dart';
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

  void _navigateToSignUpPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpPage()),
    );
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
                decoration: inputDecoration('Email', const Icon(Icons.email)),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _controllerPassword,
                obscureText: true,
                decoration: inputDecoration('Password', const Icon(Icons.lock)),
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
              const SizedBox(height: 16.0),
              _loginOrRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }
}
