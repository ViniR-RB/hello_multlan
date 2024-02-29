import 'package:flutter/material.dart';
import 'package:hellomultlan/app/core/helpers/messages.dart';
import 'package:hellomultlan/app/core/widgets/debounce_button.dart';
import 'package:hellomultlan/app/modules/auth/controller/register_controller.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  final RegisterController controller;
  const RegisterPage({super.key, required this.controller});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with MessageViewMixin {
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    messageListener(widget.controller);
    effect(() => {
          if (widget.controller.isSuccessRegister == true)
            {
              Navigator.of(context).canPop()
                  ? Navigator.of(context).pop()
                  : null,
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register Page'),
        ),
        body: Form(
          key: formKey,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _nameEC,
                      validator: Validatorless.multiple([
                        Validatorless.required("Campo Requerido"),
                        Validatorless.min(6, "Campo Precisa de 6 caracteres"),
                      ]),
                      decoration: const InputDecoration(labelText: "Nome"),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _emailEC,
                      validator: Validatorless.multiple([
                        Validatorless.required("Campo Requerido"),
                        Validatorless.email(
                            "Campo não está no formato de E-mail"),
                      ]),
                      decoration: const InputDecoration(labelText: "Email"),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Watch.builder(
                      builder: (_) => TextFormField(
                        controller: _passwordEC,
                        obscureText: widget.controller.isObscurePassword,
                        validator: Validatorless.multiple([
                          Validatorless.required("Campo Requerido"),
                          Validatorless.min(8, "Campo precisa de 8 caracteres"),
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
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      height: 52,
                      child: DebounceButton(
                          onPressed: () async {
                            final valid =
                                formKey.currentState?.validate() ?? false;
                            if (valid) {
                              return await widget.controller.register(
                                  _emailEC.text,
                                  _nameEC.text,
                                  _passwordEC.text);
                            }
                          },
                          text: "Registrar"),
                    ),
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                      onPressed: () => Navigator.of(context).canPop()
                          ? Navigator.of(context).pop()
                          : null,
                      child: const Text("Você já tem uma conta? Faça login!")))
            ],
          ),
        ));
  }
}
