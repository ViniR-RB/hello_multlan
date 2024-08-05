import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hellomultlan/app/core/either/either.dart';
import 'package:hellomultlan/app/core/exceptions/gateway_exception.dart';
import 'package:hellomultlan/app/core/helpers/loader.dart';
import 'package:hellomultlan/app/core/helpers/messages.dart';
import 'package:hellomultlan/app/core/models/box_model.dart';
import 'package:hellomultlan/app/modules/box/gateway/box_gateway.dart';
import 'package:signals_flutter/signals_flutter.dart';

class BoxEditController with MessageStateMixin, LoaderControllerMixin {
  final ValueSignal<BoxModel?> _boxModel = ValueSignal<BoxModel?>(null);

  BoxModel get boxModel => _boxModel()!;
  final BoxGateway _gateway;

  late final TextEditingController _totalClientsEC;
  TextEditingController get totalClientsEC => _totalClientsEC;

  late final TextEditingController _totalClientsActivatedEC;

  late final TextEditingController _note;
  TextEditingController get note => _note;

  TextEditingController get totalClientsActivatedEC => _totalClientsActivatedEC;

  final ValueSignal<List<TextEditingController>> _listClient = ValueSignal([]);
  List<TextEditingController> get listClient => _listClient.value;

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  BoxEditController(
      {required final BoxModel boxModel, required final BoxGateway gateway})
      : _gateway = gateway {
    _boxModel.set(boxModel, force: true);
    _initEditForm();
  }

  void _initEditForm() {
    _totalClientsEC =
        TextEditingController(text: boxModel.freeSpace.toString());
    _totalClientsActivatedEC =
        TextEditingController(text: boxModel.filledSpace.toString());
    _note = TextEditingController(text: "");
    for (var element in boxModel.listUsers) {
      _listClient
          .set([..._listClient.value, TextEditingController(text: element)]);
    }
  }

  void addNewClient() {
    _listClient.set([..._listClient.value, TextEditingController()]);
  }

  void remomveClient(int index) {
    _listClient.value.removeAt(index);
    _listClient.set(force: true, [..._listClient.value]);
  }

  Future<void> validateForm() async {
    final valid = _formKey.currentState?.validate() ?? false;
    if (valid) {
      loader(true);
      await _saveBox(
          int.parse(_totalClientsActivatedEC.text),
          int.parse(_totalClientsEC.text),
          List.generate(_listClient.value.length,
              (index) => _listClient.value[index].text),
          _note.text);
      loader(false);
    }
  }

  Future<void> _saveBox(int filledSpace, int freeSpace, List<String> listUser,
      String note) async {
    if (filledSpace > listClient.length) {
      showError(
          "Quantidade de Nome de Clientes deve ser igual ao número de clientes ativos");
      return;
    }

    final updatedBox = (
      filledSpace: filledSpace,
      freeSpace: freeSpace,
      id: _boxModel.value!.id,
      listClient: listUser,
      note: note,
    );
    final result = await _gateway.saveBox(updatedBox);
    switch (result) {
      case Sucess(:final value):
        final BoxModel(:updatedAt) = value;
        log("$value");
        _boxModel.set(_boxModel.value!.updatedBox(
          filledSpace,
          freeSpace,
          listUser,
          note,
          updatedAt,
        ));

        showSuccess("Sucesso em Salvar a Caixa");
      case Failure(exception: GatewayException(message: String message)):
        {
          showError(message);
        }
    }
  }
}
