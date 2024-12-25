import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String message;

  const ErrorPage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Multlan',
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Center(child: Text(message))),
    );
  }
}
