import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 13, 218, 105),
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text(
            'Scaffold Widget Example',
            style: TextStyle(
              backgroundColor: Colors.red,
            ),
          ),
        ),
        body: Center(
          child: Text(
            'Hello World',
            style: TextStyle(
              backgroundColor: Colors.blue,
              fontSize: 50,
              color: Colors.black,
            ),
          ),
        ),
      ),
    ),
  );
}
