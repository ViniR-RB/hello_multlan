import 'package:flutter/material.dart';
import 'package:hellomultlan/app/core/helpers/loader.dart';
import 'package:hellomultlan/app/core/helpers/messages.dart';
import 'package:hellomultlan/app/core/theme/app_theme.dart';
import 'package:hellomultlan/app/modules/box/controllers/box_edit_controller.dart';
import 'package:hellomultlan/app/modules/box/widgets/custom_text_field.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

class BoxEdit extends StatefulWidget {
  final BoxEditController controller;
  const BoxEdit({super.key, required this.controller});

  @override
  State<BoxEdit> createState() => _BoxEditState();
}

class _BoxEditState extends State<BoxEdit>
    with MessageViewMixin, LoaderViewMixin {
  late final BoxEditController _controller;

  @override
  void initState() {
    _controller = widget.controller;
    messageListener(widget.controller);
    loaderListerner(widget.controller);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    messageListener(widget.controller);
    loaderListerner(widget.controller);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _controller.formKey,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text("Editar Caixa"),
              floating: true,
              snap: true,
              actions: [
                TextButton(
                    onPressed: () {
                      _controller.validateForm();
                    },
                    child: const Text("Salvar Caixa"))
              ],
            ),
            SliverPadding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  CustomTextField(
                      label: "Total de Clientes",
                      keyboardType: TextInputType.number,
                      controller: _controller.totalClientsEC,
                      validator: Validatorless.required("Campo Requerido")),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextField(
                      label: "Clientes Ativos",
                      keyboardType: TextInputType.number,
                      controller: _controller.totalClientsActivatedEC,
                      validator: Validatorless.multiple([
                        Validatorless.required("Campo Requerido"),
                        Validatorless.max(
                            int.parse(_controller.totalClientsEC.text),
                            "Clientes Ativos não pode ser maior que o espaço disponível")
                      ])),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Text(
                        "Clientes",
                        style: AppTheme.labelInput,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          _controller.addNewClient();
                        },
                        child: const Text("Adicionar Cliente"),
                      )
                    ],
                  ),
                ]),
              ),
            ),
            Watch.builder(
              builder: (_) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 24.0, right: 24.0, bottom: 12.0),
                      child: SizedBox(
                        height: 52,
                        child: TextFormField(
                          validator: Validatorless.required("Campo Requerido"),
                          controller: _controller.listClient[index],
                          decoration: InputDecoration(
                              suffix: IconButton(
                            onPressed: () {
                              _controller.remomveClient(index);
                            },
                            icon: const Icon(Icons.remove_circle_outline),
                          )),
                          strutStyle: const StrutStyle(
                              height: 1, forceStrutHeight: true, leading: 0),
                        ),
                      ),
                    );
                  },
                  childCount: _controller.listClient.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
