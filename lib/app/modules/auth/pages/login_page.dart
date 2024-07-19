import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hellomultlan/app/core/helpers/loader.dart';
import 'package:hellomultlan/app/core/helpers/messages.dart';
import 'package:hellomultlan/app/modules/auth/controller/login_controller.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  final LoginController controller;
  const LoginPage({super.key, required this.controller});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with MessageViewMixin, LoaderViewMixin {
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    messageListener(widget.controller);
    loaderListerner(widget.controller);
    effect(() => {
          if (widget.controller.isLogged)
            {
              Modular.to.navigate(
                "/box",
              )
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _emailEC,
                      decoration: const InputDecoration(labelText: "Email"),
                      validator: Validatorless.multiple([
                        Validatorless.required("Campo obrigatório"),
                        Validatorless.email("Email inválido"),
                      ]),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Watch.builder(
                      builder: (_) => TextFormField(
                        controller: _passwordEC,
                        obscureText: widget.controller.isObscurePassword,
                        validator: Validatorless.multiple([
                          Validatorless.required("Campo obrigatório"),
                          Validatorless.min(
                              8, "Senha deve ter no mínimo 8 caracteres"),
                        ]),
                        decoration: InputDecoration(
                            labelText: "Senha",
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  widget.controller.toogleVisiblePassword(),
                              icon: Icon(
                                  widget.controller.isObscurePassword == true
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () async {
                          final valid =
                              formKey.currentState?.validate() ?? false;
                          if (valid) {
                            await widget.controller.login(
                              _emailEC.text,
                              _passwordEC.text,
                            );
                          }
                        },
                        child: const Text("Entrar"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/auth/register");
                },
                child: const Text("Criar uma Conta"),
              ),
            ),
          ],
        ));
  }
}
