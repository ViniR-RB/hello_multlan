import 'package:flutter/material.dart';
import 'package:hellomultlan/app/core/constants/images.dart';

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
              image: AssetImage(ImagesConstants.scaffoldBackgroundImage),
              fit: BoxFit.cover),
        ),
        child: child,
      ),
    );
  }
}
