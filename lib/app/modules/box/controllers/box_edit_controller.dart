import 'package:flutter/material.dart';
import 'package:hellomultlan/app/core/either/either.dart';
import 'package:hellomultlan/app/core/exceptions/gateway_exception.dart';
import 'package:hellomultlan/app/core/helpers/loader.dart';
import 'package:hellomultlan/app/core/helpers/messages.dart';
import 'package:hellomultlan/app/core/models/box_model.dart';
import 'package:hellomultlan/app/modules/box/gateway/box_gateway.dart';
import 'package:signals_flutter/signals_flutter.dart';

class BoxEditController with MessageStateMixin, LoaderControllerMixin {
  final BoxModel _boxModel;

  final BoxGateway _gateway;

  late final TextEditingController _totalClientsEC;
  TextEditingController get totalClientsEC => _totalClientsEC;

  late final TextEditingController _totalClientsActivatedEC;

  TextEditingController get totalClientsActivatedEC => _totalClientsActivatedEC;

  final ValueSignal<List<TextEditingController>> _listClient = ValueSignal([]);
  List<TextEditingController> get listClient => _listClient.value;

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  BoxEditController(
      {required final BoxModel boxModel, required final BoxGateway gateway})
      : _boxModel = boxModel,
        _gateway = gateway {
    _initEditForm();
  }

  void _initEditForm() {
    _totalClientsEC =
        TextEditingController(text: _boxModel.freeSpace.toString());
    _totalClientsActivatedEC =
        TextEditingController(text: _boxModel.filledSpace.toString());
    for (var element in _boxModel.listUsers) {
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
      await _saveBox(
          int.parse(_totalClientsActivatedEC.text),
          int.parse(_totalClientsActivatedEC.text),
          List.generate(_listClient.value.length,
              (index) => _listClient.value[index].text));
    }
  }

  Future<void> _saveBox(
      int filledSpace, int freeSpace, List<String> listUser) async {
    if (filledSpace > listClient.length) {
      showError(
          "Quantidade de Nome de Clientes deve ser igual ao número de clientes ativos");
      return;
    }
    loader(true);
    final updatedBox = (
      filledSpace: filledSpace,
      freeSpace: freeSpace,
      id: _boxModel.id,
      listClient: listUser
    );
    final result = await _gateway.saveBox(updatedBox);
    switch (result) {
      case Sucess():
        loader(false);
        showSuccess("Sucesso em Salvar a Caixa");
      case Failure(exception: GatewayException(message: String message)):
        {
          loader(false);
          showError(message);
        }
    }
  }
}
