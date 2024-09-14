import 'package:flutter/material.dart';
import 'package:mad_demo/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  //final User? user = Auth().currentUser;

  // Future<void> signOut() async {    await Auth().signOut();  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              TextFormField(
                controller: _username,
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
                obscureText: true,
                controller: _password,
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
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () => {
                    Navigator.of(context).pushNamed('Screen1')
                  }
                  ,
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
