import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hellomultlan/app/core/configuration/configuration.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> init() async {
    Future.delayed(const Duration(seconds: 2), () {
      Modular.to.navigate("/auth/login");
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text("Hello Multlan${Configuration.baseUrl}"),
    ));
  }
}
