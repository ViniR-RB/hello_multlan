import 'package:flutter/material.dart';
import 'package:hellomultlan/app/core/helpers/loader.dart';
import 'package:hellomultlan/app/core/helpers/messages.dart';
import 'package:hellomultlan/app/core/theme/app_theme.dart';
import 'package:hellomultlan/app/modules/box/controllers/box_form_controller.dart';
import 'package:hellomultlan/app/modules/box/widgets/custom_text_field.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

class BoxFormPage extends StatefulWidget {
  final BoxFormController controller;
  const BoxFormPage({super.key, required this.controller});

  @override
  State<BoxFormPage> createState() => _BoxFormPageState();
}

class _BoxFormPageState extends State<BoxFormPage>
    with MessageViewMixin, LoaderViewMixin {
  List<Widget> icons = <Widget>[
    const Icon(Icons.location_on),
    const Icon(Icons.location_off),
  ];
  final formKey = GlobalKey<FormState>();
  final _totalClientsEC = TextEditingController(text: "0");
  final _totalClientsActivatedEC = TextEditingController(text: "0");
  final _addressEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    messageListener(widget.controller);
    loaderListerner(widget.controller);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
        body: Form(
      key: formKey,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text("Criar Caixa"),
            floating: true,
            snap: true,
            actions: [
              TextButton(
                  onPressed: () {
                    final valid = formKey.currentState?.validate() ?? false;
                    if (valid) {
                      widget.controller.sendBox(
                          int.parse(_totalClientsActivatedEC.text),
                          int.parse(_totalClientsEC.text),
                          _addressEC.text);
                    }
                  },
                  child: const Text("Criar Caixa"))
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Row(
                    children: [
                      Text(
                        "Imagem de Perfil",
                        style: AppTheme.labelInput,
                      ),
                    ],
                  ),
                  Watch.builder(
                    builder: (_) =>
                        switch (widget.controller.fileImage.path.isEmpty) {
                      true => CircleAvatar(
                          radius: 50,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                tileMode: TileMode.clamp,
                                colors: [
                                  Colors.black.withOpacity(0.5),
                                  Colors.black.withOpacity(0.0),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: const [0.0, 0.8],
                              ),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt),
                              onPressed: () async =>
                                  await widget.controller.getImage(),
                            ),
                          ),
                        ),
                      false => InkWell(
                          onTap: () async => await widget.controller.getImage(),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                FileImage(widget.controller.fileImage),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  tileMode: TileMode.clamp,
                                  colors: [
                                    Colors.black.withOpacity(0.5),
                                    Colors.black.withOpacity(0.0),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: const [0.0, 0.8],
                                ),
                              ),
                            ),
                          ),
                        ),
                    },
                  ),
                  CustomTextField(
                      label: "Total de Clientes",
                      keyboardType: TextInputType.number,
                      controller: _totalClientsEC,
                      validator: Validatorless.multiple([
                        Validatorless.required("Campo Requerido"),
                      ])),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextField(
                      label: "Clientes Ativos",
                      keyboardType: TextInputType.number,
                      controller: _totalClientsActivatedEC,
                      validator: Validatorless.multiple([
                        Validatorless.required("Campo Requerido"),
                        Validatorless.min(int.parse(_totalClientsEC.text),
                            "Clientes Ativos não pode ser maior que o espaço disponível")
                      ])),
                  const SizedBox(
                    height: 24,
                  ),
                  Watch.builder(
                    builder: (_) => Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        SizedBox(
                          width: size.width * .6,
                          child: TextFormField(
                            controller: _addressEC,
                            enabled:
                                widget.controller.selectedGps.value[1] == true,
                            validator: widget.controller.selectedGps.value[1] ==
                                    true
                                ? Validatorless.required("Campo é requerido")
                                : null,
                            decoration: const InputDecoration(
                                labelText: 'Insira um endereço com cep'),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        ToggleButtons(
                            direction: Axis.horizontal,
                            onPressed: (int index) {
                              widget.controller.selectedGps.set(
                                List<bool>.generate(
                                    widget.controller.selectedGps.value.length,
                                    (i) => i == index),
                                force: true,
                              );
                            },
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            selectedBorderColor: Colors.blue[700],
                            isSelected: widget.controller.selectedGps.value,
                            children: icons)
                      ],
                    ),
                  ),
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
                          widget.controller.addNewClient();
                        },
                        child: const Text("Adicionar Cliente"),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Watch.builder(
            builder: (context) => SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 24.0, right: 24.0, bottom: 12.0),
                    child: SizedBox(
                      height: 52,
                      child: TextFormField(
                        validator: Validatorless.required("Campo Requerido"),
                        controller: widget.controller.listClient.value[index],
                        decoration: InputDecoration(
                            suffix: IconButton(
                          onPressed: () {
                            widget.controller.removeClient(index);
                          },
                          icon: const Icon(Icons.remove_circle_outline),
                        )),
                        strutStyle: const StrutStyle(
                            height: 1, forceStrutHeight: true, leading: 0),
                      ),
                    ),
                  );
                },
                childCount: widget.controller.listClient.value.length,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
