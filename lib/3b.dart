import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Media Query",
      home: const ResponsivePage(),
    ),
  );
}

class ResponsivePage extends StatelessWidget {
  const ResponsivePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen width using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;

    // Breakpoint
    bool isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: Colors.grey,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (isMobile) {
            // MOBILE LAYOUT
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(14),
                  child: Text(
                    "Media Query",
                    style: TextStyle(fontSize: 20),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    "Mobile Layout",
                    style: TextStyle(fontSize: 20),
                  ),
                ),

                const SizedBox(height: 10),

                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          color: Colors.blue,
                          child: Stack(
                            children: [
                              const Center(
                                child: Text(
                                  "This is 1216 Mobile Layout.",
                                ),
                              ),

                              Positioned(
                                top: 10,
                                right: 10,
                                child: const Text(
                                  "24B01A12F9",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Expanded(
                        child: Container(
                          width: double.infinity,
                          color: Colors.blue,
                          child: const Center(
                            child: Text(
                              "This is 12F9 Mobile Layout.",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            // TABLET / DESKTOP LAYOUT
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(14),
                  child: Text(
                    "Media Query",
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    "Tablet/Desktop Layout",
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                const SizedBox(height: 10),

                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: Colors.red,
                    child: Stack(
                      children: [
                        const Center(
                          child: Text(
                            "This is a Desktop layout.",
                          ),
                        ),

                        Positioned(
                          top: 10,
                          right: 10,
                          child: const Text(
                            "24B01A12F9",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}