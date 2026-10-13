import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "LayoutBuilder",
      home: Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          title: const Text('LayoutBuilder'),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Center(
              child: Stack(
                children: [
                  Container(
                    width: constraints.maxWidth * 0.5,
                    height: constraints.maxHeight * 0.5,
                    color: Colors.blue,
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Text(
                      "24B01A12F9",
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ),
  );
}