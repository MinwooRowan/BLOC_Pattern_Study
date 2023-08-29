import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final String? text;
  final Widget child;
  const DefaultLayout({
    super.key,
    required this.child,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
    );
  }
}
