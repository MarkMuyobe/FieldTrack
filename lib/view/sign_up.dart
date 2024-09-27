import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../controller/auth.dart';
import '../stylers/gradient_text.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedJobTitle;
  final List<String> _jobTitles = ['Technicians', 'Admin', 'Manager'];

  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerRepeatPassword = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  String? errorMessage = '';

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
                  ),
                  style: Theme.of(context).textTheme.titleSmall,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _controllerEmail,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    labelText: 'Email',
                    labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                    enabledBorder: borderStyle,
                    focusedBorder: borderStyle,
                    errorBorder: borderStyle.copyWith(
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: borderStyle.copyWith(
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                  ),
                  style: Theme.of(context).textTheme.titleSmall,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _controllerPhone,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    labelText: 'Phone',
                    labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                    enabledBorder: borderStyle,
                    focusedBorder: borderStyle,
                    errorBorder: borderStyle.copyWith(
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: borderStyle.copyWith(
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                  ),
                  style: Theme.of(context).textTheme.titleSmall,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _controllerPassword,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    labelText: 'Password',
                    labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                    enabledBorder: borderStyle,
                    focusedBorder: borderStyle,
                    errorBorder: borderStyle.copyWith(
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: borderStyle.copyWith(
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  style: Theme.of(context).textTheme.titleSmall,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _controllerRepeatPassword,
                  obscureText: !_isConfirmPasswordVisible,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    labelText: 'Confirm Password',
                    labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                    enabledBorder: borderStyle,
                    focusedBorder: borderStyle,
                    errorBorder: borderStyle.copyWith(
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: borderStyle.copyWith(
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                  style: Theme.of(context).textTheme.titleSmall,
                  validator: (value) {
                    if (value != _controllerPassword.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return SimpleDialog(
                                backgroundColor: Colors.black,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                children: _jobTitles.map((String jobTitle) {
                                  return SimpleDialogOption(
                                    onPressed: () {
                                      setState(() {
                                        _selectedJobTitle = jobTitle;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                                      child: Text(
                                        jobTitle,
                                        style: const TextStyle(color: Colors.green, fontSize: 16),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          );
                        },
                        child: InputDecorator(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
                            labelText: 'Job Title',
                            labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                            enabledBorder: borderStyle,
                            focusedBorder: borderStyle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              _selectedJobTitle ?? 'Select Job Title',
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(5.0),
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
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
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
