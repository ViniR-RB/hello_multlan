import 'package:flutter/material.dart';

class CustomScaffoldForegroud extends StatelessWidget {
  final PreferredSizeWidget? customAppBar;
  final Widget child;
  const CustomScaffoldForegroud(
      {super.key, this.customAppBar, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar,
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              opacity: 0.1,
              image: AssetImage("assets/img/background_1.png"),
              fit: BoxFit.cover),
        ),
        child: child,
      ),
    );
  }
}
