import 'package:flutter/material.dart';

void main() {
  var text = Text(
    'Hello World',
    style: TextStyle(
      backgroundColor: Colors.blue,
      fontSize: 30,
      decoration: TextDecoration.underline,
      color: Colors.red,
    ),
  );

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'First program',
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: text,
        ),
      ),
    ),
  );
}
