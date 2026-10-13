import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    //theme: ThemeData.light(),
    //theme: ThemeData.dark(),

    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      hintColor: Colors.amber,
      scaffoldBackgroundColor: Colors.greenAccent,

      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.grey),
        headlineLarge: TextStyle(
          fontSize: 40,
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.red,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.amber,
        ),
      ),
    ),

    home: FirstScreen(),
  ));
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blue,

      appBar: AppBar(
        title: Text('First Page'),
      ),

      body: Column(
        children: [
          Text(
            'First Screen',
            style: Theme.of(context).textTheme.headlineLarge,
          ),

          const SizedBox(height: 30),

          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SecondScreen(),
                ),
              );
            },
            icon: Icon(Icons.arrow_forward, size: 20),
            label: Text('Second Page'),
          ),
        ],
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.green,

      appBar: AppBar(
        title: Text('Second Page'),
      ),

      body: Column(
        children: [
          Text(
            'Second Screen',
            style: TextTheme.of(context)
                .headlineSmall!
                .copyWith(color: Colors.amber),
          ),

          const SizedBox(height: 30),

          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ThirdScreen(),
                ),
              );
            },
            icon: Icon(Icons.arrow_forward, size: 20),
            label: Text('Third Page'),
          ),
        ],
      ),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.red,

      appBar: AppBar(
        title: Text('Third Page'),
      ),

      body: Column(
        children: [
          const Text(
            'Third Screen',
            style: TextStyle(fontSize: 30),
          ),

          const SizedBox(height: 30),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FirstScreen(),
                ),
              );
            },
            child: const Text('First Page'),
          ),

          const SizedBox(height: 50),

          FloatingActionButton(
            child: Icon(
              Icons.arrow_back,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}