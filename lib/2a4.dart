import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Button display',
      home: Scaffold(
        backgroundColor: Colors.blue,

        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text('Button Widget Example'),
        ),

        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                print('This is Elevated Button');
              },
              child: Text('Elevated Button'),
            ),

            TextButton(
              onPressed: () {
                print('This is Text Button');
              },
              child: Text('Text Button'),
            ),

            OutlinedButton(
              onPressed: () {
                print('This is Outlined button');
              },
              child: Image.asset(
                'assets/images/fish.jpg',
                width: 175,
                height: 130,
              ),
            ),

            IconButton(
              onPressed: () {
                print('This is Icon Button');
              },
              icon: Icon(Icons.thumb_up),
            ),

            FloatingActionButton(
              onPressed: () {
                print('This is Floating action button');
              },
              shape: CircleBorder(
                side: BorderSide(
                  color: Colors.red,
                  width: 5,
                ),
              ),
              child: Icon(Icons.add),
            ),

            RawMaterialButton(
              onPressed: () {
                print('This is Raw material button');
              },
              fillColor: Colors.amber,
              shape: CircleBorder(
                side: BorderSide(
                  color: Colors.red,
                  width: 5,
                ),
              ),
              child: Icon(Icons.star),
            ),
          ],
        ),
      ),
    ),
  );
}