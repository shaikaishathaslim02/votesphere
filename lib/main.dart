import 'package:flutter/material.dart';
import 'services/poll_service.dart';
import 'screens/home_screen.dart';

void main() => runApp(const VoteSphereApp());

class VoteSphereApp extends StatelessWidget {
  const VoteSphereApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VoteSphere',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff3857d6)),
        scaffoldBackgroundColor: const Color(0xfff6f7fb),
        inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
      ),
      home: HomeScreen(service: PollService()),
    );
  }
}
