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
      title: "Navigation Using Routes",

      // Named Routes
      initialRoute: '/',

      routes: {
        '/': (context) => const FirstPage(),
        '/second': (context) => const SecondPage(),
        '/third': (context) => const ThirdPage(),
      },
    );
  }
}



class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "First Page",
          style: TextStyle(fontSize: 16),
        ),
      ),

      body: Container(
        color: Colors.blue,
        child: Stack(
          children: [

            // Roll Number
            const Positioned(
              top: 10,
              right: 8,
              child: Text(
                "24B01A12G0",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                ),
              ),
            ),

           
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const Text(
                    "First Screen",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(height: 25),

                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/second',
                      );
                    },

                    icon: const Icon(
                      Icons.arrow_forward,
                      size: 14,
                    ),

                    label: const Text(
                      "Second Page",
                      style: TextStyle(fontSize: 10),
                    ),

                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Second Page",
          style: TextStyle(fontSize: 16),
        ),
      ),

      body: Container(
        color: Colors.green,
        child: Stack(
          children: [

            const Positioned(
              top: 10,
              right: 8,
              child: Text(
                "24B01A12F9",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                ),
              ),
            ),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const Text(
                    "Second Screen",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(height: 25),

                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/third',
                      );
                    },

                    icon: const Icon(
                      Icons.arrow_forward,
                      size: 14,
                    ),

                    label: const Text(
                      "Third Page",
                      style: TextStyle(fontSize: 10),
                    ),

                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Third Page",
          style: TextStyle(fontSize: 16),
        ),
      ),

      body: Container(
        color: Colors.orange,
        child: Stack(
          children: [

            
            const Positioned(
              top: 10,
              right: 8,
              child: Text(
                "24B01A12F9",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                ),
              ),
            ),

           
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const Text(
                    "Third Screen",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(height: 25),

                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    icon: const Icon(
                      Icons.arrow_back,
                      size: 14,
                    ),

                    label: const Text(
                      "Go Back",
                      style: TextStyle(fontSize: 10),
                    ),

                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}