import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final PreferredSizeWidget? customAppBar;
  final Widget child;
  const CustomScaffold({super.key, this.customAppBar, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              opacity: 0.45,
              image: AssetImage("assets/img/background_1.png"),
              fit: BoxFit.cover),
        ),
        child: child,
      ),
    );
  }
}
