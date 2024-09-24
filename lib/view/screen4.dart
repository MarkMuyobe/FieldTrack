import 'package:flutter/material.dart';

class Screen4 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.three_g_mobiledata),
            Text('Screen 4'),
          ],
        ),
      ),
    );
  }

}