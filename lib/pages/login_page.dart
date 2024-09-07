import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth.dart';

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

  Future<void> signInWithEmailAndPassword() async{
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text,
          password: _controllerPassword.text);
    } on  FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail,
          password: _controllerPassword);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _errorMessage(){
    return Text(errorMessage == '' ? '' : 'Hmm? $errorMessage');
  }

  Widget _loginOrRegisterButton(){
    return TextButton(onPressed: (){
      setState(() {
        isLogin = !isLogin;
      });
    },
        child: Text(isLogin? 'Register instead' : 'Login instead'));
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Login/Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              TextFormField(
                controller: _controllerEmail,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24.0))
                  ),
                ),
                keyboardType: TextInputType.name,
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: _controllerPassword,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(
                      Icons.sticky_note_2_outlined
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24.0))
                  ),
                ),
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 20),
              _errorMessage(),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () => {
                    isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword
                  }
                  ,
                  child: Text( isLogin ? 'Login' : 'Register'),
                ),
              ),
              _loginOrRegisterButton(),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
