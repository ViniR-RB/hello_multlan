import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, "/auth/register");
                    },
                    child: const Text("Criar uma Conta")),
              )
            ],
          ),
        ));
  }
}
