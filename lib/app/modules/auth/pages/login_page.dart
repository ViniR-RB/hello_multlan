import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hellomultlan/app/core/helpers/loader.dart';
import 'package:hellomultlan/app/core/helpers/messages.dart';
import 'package:hellomultlan/app/core/theme/app_colors.dart';
import 'package:hellomultlan/app/core/widgets/custom_scaffold_primary.dart';
import 'package:hellomultlan/app/core/widgets/custom_text_field.dart';
import 'package:hellomultlan/app/core/widgets/logo_widget.dart';
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
                "/box/",
              )
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    final Size(:height) = MediaQuery.sizeOf(context);
    return CustomScaffoldPrimary(
        child: Stack(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 75.0),
          child: Align(alignment: Alignment.topCenter, child: LogoWidget()),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: height * 0.6,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32), topRight: Radius.circular(32)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 54.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 42,
                    ),
                    Text(
                      "Faça Login",
                      style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor),
                    ),
                    const SizedBox(
                      height: 42,
                    ),
                    CustomTextField(
                      label: "E-mail",
                      labelExample: "Digite um E-mail",
                      controller: _emailEC,
                      validator: Validatorless.multiple([
                        Validatorless.required("Campo obrigatório"),
                        Validatorless.email("Email inválido"),
                      ]),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                      label: "Senha",
                      labelExample: "Digite sua senha",
                      controller: _passwordEC,
                      validator: Validatorless.multiple([
                        Validatorless.required("Campo obrigatório"),
                        Validatorless.min(
                            8, "Senha deve ter no mínimo 8 caracteres"),
                      ]),
                      isPassword: widget.controller.isObscurePassword,
                      icon: IconButton(
                        onPressed: () =>
                            widget.controller.toogleVisiblePassword(),
                        icon: Icon(widget.controller.isObscurePassword == true
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                    // Watch.builder(
                    //   builder: (_) => TextFormField(
                    //     controller: _passwordEC,
                    //     obscureText: widget.controller.isObscurePassword,
                    //     validator: Validatorless.multiple([
                    //       Validatorless.required("Campo obrigatório"),
                    //       Validatorless.min(
                    //           8, "Senha deve ter no mínimo 8 caracteres"),
                    //     ]),
                    //     decoration: InputDecoration(
                    //         labelText: "Senha",
                    //         suffixIcon: IconButton(
                    //           onPressed: () =>
                    //               widget.controller.toogleVisiblePassword(),
                    //           icon: Icon(
                    //               widget.controller.isObscurePassword == true
                    //                   ? Icons.visibility
                    //                   : Icons.visibility_off),
                    //         )),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width,
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
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/auth/register");
            },
            child: const Text(
              "Não tem uma conta? Cadastre-se!",
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          ),
        ),
      ],
    ));
  }
}
