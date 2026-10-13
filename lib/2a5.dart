import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 13, 218, 105),

        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Center(
            child: Text(
              'Container Widget Example',
              style: TextStyle(
                backgroundColor: Colors.red,
                fontSize: 25,
              ),
            ),
          ),
        ),

        body: Container(
          width: 200,
          height: 200,
          //color: Colors.red,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(30),

          decoration: BoxDecoration(
            border: Border.all(
              width: 20,
              color: Colors.blue,
            ),
            color: Colors.red,
          ),

          alignment: Alignment.bottomRight,

          child: Text(
            'Hi this shri vishnu engineering college for women',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    ),
  );
}