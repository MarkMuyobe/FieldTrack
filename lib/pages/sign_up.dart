import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth.dart'; // Ensure your authentication logic is included here
import 'login_page.dart'; // Import the LoginPage

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? errorMessage = '';
  bool isSignUp = true; // Allows switching between login and sign-up

  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerRepeatPassword = TextEditingController();
  String? _selectedJobTitle;
  final List<String> _jobTitles = ['Technicians', 'Admin', 'Manager'];

  @override
  void dispose() {
    _controllerUsername.dispose();
    _controllerEmail.dispose();
    _controllerPhone.dispose();
    _controllerPassword.dispose();
    _controllerRepeatPassword.dispose();
    super.dispose();
  }

  Future<void> createUserWithEmailAndPassword() async {
    if (_controllerPassword.text == _controllerRepeatPassword.text) {
      try {
        await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text,
          password: _controllerPassword.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account created successfully')),
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          errorMessage = e.message;
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
    const borderColor = Color(0xFF4ECB71);

    InputDecoration _inputDecoration(String labelText, Icon icon) {
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
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4ECB71), // Green color
                ),
              ),
              const SizedBox(height: 32.0), // Add space after title

              TextFormField(
                controller: _controllerUsername,
                decoration: _inputDecoration('Username', const Icon(Icons.person)),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _controllerEmail,
                decoration: _inputDecoration('Email', const Icon(Icons.email)),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _controllerPhone,
                decoration: _inputDecoration('Phone', const Icon(Icons.phone)),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _controllerPassword,
                obscureText: true,
                decoration: _inputDecoration('Password', const Icon(Icons.lock)),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _controllerRepeatPassword,
                obscureText: true,
                decoration: _inputDecoration('Confirm Password', const Icon(Icons.lock_outline)),
              ),
              const SizedBox(height: 16.0),
              FractionallySizedBox(
                widthFactor: 0.5, // Adjusts the width to 50%
                child: DropdownButtonFormField<String>(
                  decoration: _inputDecoration('Job Title', const Icon(Icons.work)),
                  value: _selectedJobTitle,
                  items: _jobTitles.map((String jobTitle) {
                    return DropdownMenuItem<String>(
                      value: jobTitle,
                      child: Text(jobTitle),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedJobTitle = newValue;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16.0),

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
