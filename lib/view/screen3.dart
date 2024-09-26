import 'package:flutter/material.dart';
import 'package:mad_demo/model/mad_theme.dart';

class Screen3 extends StatelessWidget {
  Screen3({super.key});
  final ThemeData theme = MadTheme.dark();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.three_g_mobiledata),
            Text('Screen 3', style: theme.textTheme.titleMedium),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Go back to screen 2',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 24.0),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.arrow_right),
                    Text('Go back', style: theme.textTheme.labelLarge),
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}
