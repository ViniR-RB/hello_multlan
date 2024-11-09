import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hellomultlan/app/app_controller.dart';

class SplashPage extends StatefulWidget {
  final AppController contoller;
  const SplashPage({super.key, required this.contoller});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> init() async {
    widget.contoller.checkToken();
  }

  @override
  void initState() {
    init();
    widget.contoller.isAuthenticated.addListener(() {
      if (widget.contoller.isAuthenticated.value == true) {
        Modular.to.navigate(
          "/box/",
        );
      } else {
        Modular.to.navigate("/auth/login");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text("Hello Multlan"),
    ));
  }
}
