import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/input_decoration.dart';
import '../stylers/gradient_text.dart';
import 'login_page.dart';
import '../model/user_provider.dart';
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

  String? errorMessage;

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
          uid: '',
          firstName: _controllerFirstName.text,
          surname: _controllerSurname.text,
          email: _controllerEmail.text,
          phoneNumber: _controllerPhone.text,
          role: UserRole.user,
        );

        await Provider.of<UserProvider>(context, listen: false)
            .signUp(newUser, _controllerPassword.text);

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
    if (errorMessage == null) return Container();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        errorMessage!,
        style: const TextStyle(color: Colors.red),
      ),
    );
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
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.name,
                  controller: _controllerFirstName,
                  decoration:
                  inputDecoration('First Name', const Icon(Icons.person)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.name,
                  controller: _controllerSurname,
                  decoration:
                  inputDecoration('Surname', const Icon(Icons.person)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your surname';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _controllerEmail,
                  decoration:
                  inputDecoration('Email', const Icon(Icons.email)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _controllerPhone,
                  decoration:
                  inputDecoration('Phone', const Icon(Icons.phone)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _controllerPassword,
                  obscureText: true,
                  decoration:
                  inputDecoration('Password', const Icon(Icons.lock)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password should be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _controllerRepeatPassword,
                  obscureText: true,
                  decoration: inputDecoration(
                      'Confirm Password', const Icon(Icons.lock_outline)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _controllerPassword.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                _errorMessage(),
                FractionallySizedBox(
                  widthFactor: 0.5,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        createUserWithEmailAndPassword();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      backgroundColor: const Color(0xFF4ECB71),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
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
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor),
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
