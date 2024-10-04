
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
//import '../controller/auth.dart';
import '../model/input_decoration.dart';

import '../stylers/gradient_text.dart';
import 'login_page.dart';
import 'package:provider/provider.dart';
import '../controller/user_provider.dart';
import '../model/user.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedJobTitle;
  final List<String> _jobTitles = ['Technicians', 'Admin', 'Manager'];

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

  @override
  Widget build(BuildContext context) {

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _controllerUsername,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    labelText: 'Full Name',
                    labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                    enabledBorder: borderStyle,
                    focusedBorder: borderStyle,
                    errorBorder: borderStyle.copyWith(
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: borderStyle.copyWith(
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    prefixIcon: const Icon(Icons.person), // Added icon here
                  ),
                  style: Theme.of(context).textTheme.titleSmall,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                fontSize: 40,
                fontFamily: 'Amuse-Bouche',  // Optional: Your custom font
              ),
              const SizedBox(height: 32.0), // Add space after title

              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.name,
                controller: _controllerFirstName,
                decoration: inputDecoration('First Name', const Icon(Icons.person)),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.name,
                controller: _controllerSurname,
                decoration: inputDecoration('Surname', const Icon(Icons.person)),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _controllerEmail,
                decoration: inputDecoration('Email', const Icon(Icons.email)),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                keyboardType: TextInputType.phone
                ,
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          createUserWithEmailAndPassword();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    TextButton(
                      onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()),);},
                      child: Text('Login', style: TextStyle(color: Theme.of(context).primaryColor),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
