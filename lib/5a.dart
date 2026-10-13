import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

// State class
class _CounterPageState extends State<CounterPage> {
  int count = 0;

  void increment() {
    setState(() {
      count++;
    });
  }

  void decrement() {
    setState(() {
      count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stateful Widget"),
      ),

      body: Stack(
        children: [
          const Positioned(
            top: 10,
            right: 8,
            child: Text(
              "24B01A12F9",
              style: TextStyle(
                fontSize: 10,
                color: Colors.black,
              ),
            ),
          ),

          // Main Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Counter",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  "$count",
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: decrement,
                      child: const Text("-"),
                    ),

                    const SizedBox(width: 20),

                    ElevatedButton(
                      onPressed: increment,
                      child: const Text("+"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}