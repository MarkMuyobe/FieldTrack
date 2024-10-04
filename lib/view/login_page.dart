import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mad_demo/model/models.dart';
import 'package:provider/provider.dart';
import '../model/user_provider.dart';
import '../stylers/gradient_text.dart';
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

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

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
    return errorMessage == null || errorMessage!.isEmpty
        ? const SizedBox.shrink()
        : Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Text(
        'Error: $errorMessage',
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  void _navigateToSignUpPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const borderColor = Color(0xFF4ECB71);

    final borderStyle = OutlineInputBorder(
      borderSide: const BorderSide(color: borderColor, width: 1.5),
      borderRadius: BorderRadius.circular(20),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: GradientText(
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
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32.0),
              TextFormField(
                controller: _controllerEmail,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(16.0),
                  labelText: 'Email',
                  border: borderStyle,
                  focusedBorder: borderStyle,
                  enabledBorder: borderStyle,
                  prefixIcon: const Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _controllerPassword,
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(16.0),
                  labelText: 'Password',
                  border: borderStyle,
                  focusedBorder: borderStyle,
                  enabledBorder: borderStyle,
                  prefixIcon: const Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 10.0),
              _errorMessage(),
              const SizedBox(height: 10.0),
              FractionallySizedBox(
                widthFactor: 0.5,
                child: GestureDetector(
                  onTap: isLoading ? null : signInWithEmailAndPassword,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4ECB71), Color(0xFF276538)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: ElevatedButton(
                      onPressed: isLoading ? null : signInWithEmailAndPassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  TextButton(
                    onPressed: _navigateToSignUpPage,
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
