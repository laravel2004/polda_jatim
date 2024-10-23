import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseTemplate extends StatelessWidget {
  final Widget child;
  const BaseTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: child,
        ),
      ),
    );
  }

}