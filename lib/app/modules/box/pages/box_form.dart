import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hellomultlan/app/core/helpers/messages.dart';
import 'package:hellomultlan/app/modules/box/controllers/box_form_controller.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

class BoxForm extends StatefulWidget {
  final BoxFormController controller;
  const BoxForm({super.key, required this.controller});

  @override
  State<BoxForm> createState() => _BoxFormState();
}

class _BoxFormState extends State<BoxForm> with MessageViewMixin {
  final selectedGps = ValueSignal<List<bool>>([true, false]);
  List<Widget> icons = <Widget>[
    const Icon(Icons.location_on),
    const Icon(Icons.location_off),
  ];
  final formKey = GlobalKey<FormState>();
  final _referenceEC = TextEditingController();
  final _totalClientsEC = TextEditingController();
  final _totalClientsActivatedEC = TextEditingController();
  final _addressEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    messageListener(widget.controller);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Caixa'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: size.height,
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _referenceEC,
                    decoration: const InputDecoration(labelText: 'Referencia'),
                    validator: Validatorless.required("Campo é requerido"),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _totalClientsEC,
                    validator: Validatorless.required("Campo é requerido"),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Capacidade de Clientes'),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _totalClientsActivatedEC,
                    validator: Validatorless.required("Campo é requerido"),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Total de Clientes Ativos'),
                  ),
                  const SizedBox(
                    height: 8,
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
                            enabled: selectedGps.value[1] == true,
                            validator: selectedGps.value[1] == true
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
                              selectedGps.set(
                                List<bool>.generate(selectedGps.value.length,
                                    (i) => i == index),
                                force: true,
                              );
                            },
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            selectedBorderColor: Colors.blue[700],
                            isSelected: selectedGps.value,
                            children: icons)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: size.width,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () async {
                        final valid = formKey.currentState?.validate() ?? false;
                        if (valid) {
                          if (selectedGps.value[1] == true) {
                            await widget.controller
                                .getLocationByAddres(_addressEC.text);
                          } else {
                            await widget.controller.getLocation();
                          }
                          await widget.controller.sendBox(
                            int.parse(_totalClientsActivatedEC.text),
                            widget.controller.fileImage,
                            _referenceEC.text,
                            int.parse(_totalClientsEC.text),
                          );
                        }
                      },
                      child: const Text("Enviar"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
