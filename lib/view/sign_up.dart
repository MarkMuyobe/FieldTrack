//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
//import '../controller/auth.dart';
import '../model/input_decoration.dart';
import '../stylers/gradient_text.dart';
import 'login_page.dart';
import 'package:provider/provider.dart';
import '../model/user_provider.dart';
import '../model/user.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? errorMessage = '';
  bool isSignUp = true; // Allows switching between login and sign-up

  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerSurname = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerRepeatPassword = TextEditingController();

  @override
  void dispose() {
    _controllerFirstName.dispose();
    _controllerSurname.dispose();
    _controllerEmail.dispose();
    _controllerPhone.dispose();
    _controllerPassword.dispose();
    _controllerRepeatPassword.dispose();
    super.dispose();
  }

  Future<void> createUserWithEmailAndPassword() async {
    if (_controllerPassword.text == _controllerRepeatPassword.text) {
      try {
        final newUser = User(
          uid: '', // This will be set by Firebase
          firstName: _controllerFirstName.text,
          surname: _controllerSurname.text,
          email: _controllerEmail.text,
          phoneNumber: _controllerPhone.text,
          role: UserRole.user, // Default role set to 'user'
        );

        await Provider.of<UserProvider>(context, listen: false).signUp(newUser, _controllerPassword.text);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account created successfully')),
        );
        Navigator.of(context).pushNamed('/homepage');
      } catch (e) {
        setState(() {
          errorMessage = e.toString();
        });
      }
    } else {
      setState(() {
        errorMessage = "Passwords do not match";
      });
    }
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Hmm? $errorMessage');
  }

  void _navigateToLoginPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  Widget _signUpOrLoginButton() {
    return TextButton(
      onPressed: () {
        if (isSignUp) {
          _navigateToLoginPage();
        } else {
          setState(() {
            isSignUp = !isSignUp;
          });
        }
      },
      child: Text(isSignUp ? 'Already have an account? Login' : 'Don\'t have an account? Sign up instead'),
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF4ECB71), // Adjust color as needed
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //const borderColor = Color(0xFF4ECB71);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              const GradientText(
                'FIELDTRACK',
                gradient: LinearGradient(
                  colors: [Color(0xFF4ECB71), // Hex color for #4ECB71 (green)
                    Color(0xFF276538),],
                ),
                fontSize: 40,
                fontFamily: 'Amuse-Bouche',  // Optional: Your custom font
              ),
              const SizedBox(height: 32.0), // Add space after title

              TextFormField(
                controller: _controllerFirstName,
                decoration: inputDecoration('First Name', const Icon(Icons.person)),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _controllerSurname,
                decoration: inputDecoration('Surname', const Icon(Icons.person)),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _controllerEmail,
                decoration: inputDecoration('Email', const Icon(Icons.email)),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _controllerPhone,
                decoration: inputDecoration('Phone', const Icon(Icons.phone)),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _controllerPassword,
                obscureText: true,
                decoration: inputDecoration('Password', const Icon(Icons.lock)),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _controllerRepeatPassword,
                obscureText: true,
                decoration: inputDecoration('Confirm Password', const Icon(Icons.lock_outline)),
              ),
              const SizedBox(height: 16.0),
              _errorMessage(),

              FractionallySizedBox(
                widthFactor: 0.5, // Adjusts the width to 50%
                child: GestureDetector(
                  onTap: () => createUserWithEmailAndPassword(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF4ECB71), // #4ECB71 (light green)
                          Color(0xFF276538), // #276538 (dark green)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24.0), // Rounded edges
                    ),
                    child: const Text(
                      'Sign Up',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              _signUpOrLoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
