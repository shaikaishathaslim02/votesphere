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
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Items"),
        ),
        body: ListView(
          children: const [
            ItemWidget(
              name: "Mobile Phone",
              price: "10000",
              image: "assets/Flutter_images.jpg",
              description: "real me Phone, 5 GB RAM",
            ),
            ItemWidget(
              name: "Laptop",
              price: "70000",
              image: "assets/Flutter_image2.jpg",
              description: "Vivo Laptop, 16 GB RAM",
            ),
            ItemWidget(
              name: "Pen Drive",
              price: "200",
              image: "assets/flutter_image3.jpg",
              description: "Pen Drive, 32 GB",
            ),
          ],
        ),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  final String name;
  final String price;
  final String image;
  final String description;

  const ItemWidget({
    super.key,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Item: $name"),
                  Text("Price: ₹$price"),
                ],
              ),
            ),

            Image.network(
              image,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(description),
              ),
            ),
          ],
        ),
      ),
    );
  }
}