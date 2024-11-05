import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hellomultlan/app/core/helpers/loader.dart';
import 'package:hellomultlan/app/core/helpers/messages.dart';
import 'package:hellomultlan/app/core/helpers/zone.object.dart';
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
  final _labelEC = TextEditingController();
  final _totalClientsEC = TextEditingController();
  final _totalClientsActivatedEC = TextEditingController();
  final _addressEC = TextEditingController();
  final _signalEC = TextEditingController();
  final ValueNotifier<String?> _zoneSelectEC = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
    messageListener(widget.controller);
    loaderListerner(widget.controller);
  }

  @override
  void dispose() {
    messageListener(widget.controller);
    loaderListerner(widget.controller);
    widget.controller.dispose();
    _labelEC.dispose();
    _totalClientsEC.dispose();
    _totalClientsActivatedEC.dispose();
    _addressEC.dispose();
    _signalEC.dispose();
    super.dispose();
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
                          _labelEC.text,
                          int.parse(_totalClientsActivatedEC.text),
                          int.parse(_totalClientsEC.text),
                          num.parse(_signalEC.text),
                          _addressEC.text,
                          _zoneSelectEC.value!);
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
                  const SizedBox(
                    height: 8,
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
                          child: Container(
                            width: 100, // Diâmetro do círculo
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: FileImage(widget.controller.fileImage),
                                fit: BoxFit.cover,
                              ),
                            ),
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
                    label: "Rótulo",
                    labelExample: "20 / 80 Azul",
                    keyboardType: TextInputType.name,
                    controller: _labelEC,
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required("Campo Requerido"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextField(
                    label: "Total de Clientes",
                    labelExample: "0",
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
                    keyboardType: TextInputType.number,
                    controller: _totalClientsEC,
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required("Campo Requerido"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ValueListenableBuilder(
                      valueListenable: _totalClientsEC,
                      builder: (context, totalClientsEC, snapshot) {
                        return CustomTextField(
                            label: "Clientes Ativos",
                            labelExample: "0",
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]'))
                            ],
                            keyboardType: TextInputType.number,
                            controller: _totalClientsActivatedEC,
                            validator: Validatorless.multiple([
                              Validatorless.required("Campo Requerido"),
                              Validatorless.max(
                                  int.tryParse(totalClientsEC.text) ?? 0,
                                  "Clientes Ativos não pode ser maior que o espaço disponível")
                            ]));
                      }),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextField(
                      label: "Sinal",
                      labelExample: "0.0",
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
                      ],
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      controller: _signalEC,
                      validator: Validatorless.multiple([
                        Validatorless.required("Campo Requerido"),
                        Validatorless.number("Signal not a number")
                      ])),
                  const SizedBox(
                    height: 24,
                  ),
                  ValueListenableBuilder<String?>(
                    valueListenable: _zoneSelectEC,
                    builder: (context, selectedValue, child) {
                      return DropdownButtonFormField<String>(
                        hint: const Text('Selecione uma zona'),
                        validator: Validatorless.required(
                            "Por favor, selecione uma zona"),
                        value: selectedValue,
                        onChanged: (String? newValue) {
                          _zoneSelectEC.value = newValue;
                        },
                        items: items.map((item) {
                          return DropdownMenuItem<String>(
                            value: item['cod'],
                            child: Text(item['label']!),
                          );
                        }).toList(),
                      );
                    },
                  ),
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
                          suffixIconConstraints: const BoxConstraints(
                            minHeight: 32,
                            minWidth: 32,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              widget.controller.removeClient(index);
                            },
                            icon: const Icon(Icons.remove_circle_outline),
                          ),
                        ),
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
