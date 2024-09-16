import 'package:flutter/material.dart';
import 'package:mad_demo/mad_theme.dart';

class Screen1 extends StatelessWidget {
  Screen1({super.key});

  final ThemeData theme = MadTheme.dark();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO: Turn this page into the page in the Figma design
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.one_x_mobiledata),
            Text('Screen 1'),
          ],
        ),
      ),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Go to Screen 2',
               //style: theme.textTheme.titleMedium,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 120.0,
              child: ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pushNamed('Screen2');
                  },
                  child: const Row(
                children: [
                  Icon(Icons.arrow_right),
                  Text('Go ')
                ],
                )
              ),
            )
          ],
        )
      ),
    );
  }
}
