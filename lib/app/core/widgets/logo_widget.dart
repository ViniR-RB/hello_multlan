import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final BoxFit? fit;
  const LogoWidget({super.key, this.width, this.height, this.fit});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/img/logo_completa.png",
      width: width,
      height: height,
      fit: fit,
    );
  }
}
