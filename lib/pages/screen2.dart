import 'package:flutter/material.dart';

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.looks_two_rounded),
            Text('Screen Two')
          ]
        ),
      ),
      body: Center(
        child: Padding(

          padding: const EdgeInsets.all(44.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Go to Screen 3'),
              ElevatedButton(
                  onPressed: ()=>{
                    Navigator.of(context).pushNamed('Screen3')
                  },
                  child: Row(
                    children: [
                      Icon(Icons.three_g_mobiledata),
                      Text('Go to pagee three')
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
