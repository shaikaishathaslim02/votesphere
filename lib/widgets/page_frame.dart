import 'package:flutter/material.dart';

class PageFrame extends StatelessWidget {
  const PageFrame({super.key, required this.title, required this.child, this.onBack});
  final String title; final Widget child; final VoidCallback? onBack;
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title), leading: onBack == null ? null : BackButton(onPressed: onBack)),
    body: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 900), child: child)),
  );
}
