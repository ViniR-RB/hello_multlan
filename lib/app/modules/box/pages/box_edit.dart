import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hellomultlan/app/core/helpers/loader.dart';
import 'package:hellomultlan/app/core/helpers/messages.dart';
import 'package:hellomultlan/app/core/helpers/zone.object.dart';
import 'package:hellomultlan/app/core/theme/app_theme.dart';
import 'package:hellomultlan/app/core/widgets/custom_app_bar_sliver.dart';
import 'package:hellomultlan/app/core/widgets/custom_scaffold_foregroud.dart';
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
    messageListener(_controller);
    loaderListerner(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.disposeLoader();
    _controller.disposeMessages();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldForegroud(
      child: Form(
        key: _controller.formKey,
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(
              title: "Editar Caixa",
              actions: [
                IconButton(
                    onPressed: () async => await _controller.validateForm(),
                    icon: const Icon(Icons.save))
              ],
            ),
            SliverPadding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  CustomTextField(
                    label: "Rótulo",
                    labelExample: "20 / 80 Azul",
                    keyboardType: TextInputType.text,
                    controller: _controller.label,
                    validator: Validatorless.multiple([
                      Validatorless.required("Campo Requerido"),
                    ]),
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
                    controller: _controller.totalClientsEC,
                    validator: Validatorless.multiple([
                      Validatorless.required("Campo Requerido"),
                      Validatorless.number("Clientes Ativos não é número"),
                    ]),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ValueListenableBuilder(
                    valueListenable: _controller.totalClientsEC,
                    builder: (_, totalClientsEC, __) => CustomTextField(
                        label: "Clientes Ativos",
                        keyboardType: TextInputType.number,
                        labelExample: "0",
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                        ],
                        controller: _controller.totalClientsActivatedEC,
                        validator: Validatorless.multiple([
                          Validatorless.required("Campo Requerido"),
                          Validatorless.number("Clientes Ativos não é número"),
                        ])),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ValueListenableBuilder<String?>(
                    valueListenable: _controller.zoneEC,
                    builder: (context, selectedValue, child) {
                      return DropdownButtonFormField<String>(
                        hint: const Text('Selecione uma zona'),
                        decoration: const InputDecoration(label: Text("Zona")),
                        validator: Validatorless.required(
                            "Por favor, selecione uma zona"),
                        value: selectedValue,
                        onChanged: (String? newValue) {
                          _controller.zoneEC.value = newValue;
                        },
                        items: zoneObject.map((item) {
                          return DropdownMenuItem<String>(
                            value: item['label'],
                            child: Text(item['label']!),
                          );
                        }).toList(),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextField(
                      label: "Nota",
                      labelExample: "Adicione uma atualização",
                      keyboardType: TextInputType.text,
                      controller: _controller.note,
                      validator: Validatorless.multiple([])),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextField(
                      label: "Sinal",
                      labelExample: "0.0",
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d*')),
                      ],
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      controller: _controller.signal,
                      validator: Validatorless.multiple([
                        Validatorless.required("Campo Requerido"),
                        Validatorless.number("Sinal não é número")
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
                            suffixIconConstraints: const BoxConstraints(
                              minHeight: 32,
                              minWidth: 32,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                _controller.remomveClient(index);
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
                  childCount: _controller.listClient.length,
                ),
              ),
            ),
            SliverPadding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
              sliver: SliverList(
                  delegate: SliverChildListDelegate([
                ElevatedButton(
                  onPressed: () async => await _controller.validateForm(),
                  child: const Text("Salvar Caixa"),
                ),
              ])),
            ),
          ],
        ),
      ),
    );
  }
}
