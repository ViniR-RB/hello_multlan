import 'package:flutter/material.dart';

class CustomScaffoldPrimary extends StatelessWidget {
  final PreferredSizeWidget? customAppBar;
  final Widget child;
  const CustomScaffoldPrimary(
      {super.key, this.customAppBar, required this.child});

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
