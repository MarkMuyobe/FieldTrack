import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mad_demo/view/homepage.dart';
import '../controller/auth.dart';
import 'dashboard.dart'; // Import the Dashboard page
import 'sign_up.dart'; // Import the SignUpPage
import '../stylers/gradient_text.dart'; // Import the GradientText for the AppBar

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;
  bool _passwordVisible = false; // Password visibility toggle

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      // Navigate to the dashboard page after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage(title: 'm')),
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

  Widget _loginOrRegisterButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: Theme.of(context).textTheme.subtitle2,
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUpPage()),
            );
          },
          child: Text(
            'Sign up',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
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
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20.0),
                  labelText: 'Email',
                  labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                  enabledBorder: borderStyle, // Use the border style
                  focusedBorder: borderStyle, // Use the border style
                ),
                keyboardType: TextInputType.emailAddress,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              const SizedBox(height: 20.0),
              // Password field with visibility toggle
              TextFormField(
                controller: _controllerPassword,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20.0),
                  labelText: 'Password',
                  labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                  enabledBorder: borderStyle, // Use the border style
                  focusedBorder: borderStyle, // Use the border style
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: const Color(0xFFFFFFFF),
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible; // Toggle visibility
                      });
                    },
                  ),
                ),
                style: Theme.of(context).textTheme.subtitle2,
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
                  borderRadius: BorderRadius.circular(30.0), // Rounded edges
                ),
                child: ElevatedButton(
                  onPressed: signInWithEmailAndPassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, // Make the button background transparent
                    shadowColor: Colors.transparent, // Remove button shadow
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white, // White text color
                      fontSize: 16, // Text size for the login button
                    ),
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
