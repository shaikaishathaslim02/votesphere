import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 136, 167, 193),
        appBar: AppBar(),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "WELCOME",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                Image.asset(
                  "assets/images/vishnu_logo.png",
                  height: 200,
                  width: 200,
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        print("This is Login button");
                      },
                      child: const Text("Login"),
                    ),
                    const SizedBox(width: 60),
                    ElevatedButton(
                      onPressed: () {
                        print("This is Register button");
                      },
                      child: const Text("Register"),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      margin: const EdgeInsets.all(10),
                      child: Image.asset(
                        'assets/images/vishnu1.jpg',
                      ),
                    ),

                    const SizedBox(
                      height: 70,
                      width: 70,
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/vishnu2.jpg'),
                      ),
                    ),

                    Container(
                      height: 70,
                      width: 70,
                      margin: const EdgeInsets.all(10),
                      child: const CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/vishnu3.jpg'),
                      ),
                    ),

                    Container(
                      height: 90,
                      width: 90,
                      margin: const EdgeInsets.all(5),
                      child: Image.asset(
                        'assets/images/vishnu4.jpg',
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "Roll No: 24B01A12F9",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}