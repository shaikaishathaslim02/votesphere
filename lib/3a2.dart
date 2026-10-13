import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "LayoutBuilder",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("LayoutBuilder"),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {

            Color bgColor;

            if (constraints.maxWidth < 300) {
              bgColor = Colors.blue;
            } else if (constraints.maxWidth < 500) {
              bgColor = Colors.red;
            } else {
              bgColor = Colors.green;
            }

            return Container(
              width: double.infinity,
              height: double.infinity,
              color: bgColor,
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Text(
                      "24B01A12F9",
                      style: const TextStyle(
                        color: Colors.black,
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