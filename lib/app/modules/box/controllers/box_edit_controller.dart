import 'package:flutter/material.dart';
import 'package:hellomultlan/app/core/either/either.dart';
import 'package:hellomultlan/app/core/exceptions/gateway_exception.dart';
import 'package:hellomultlan/app/core/helpers/loader.dart';
import 'package:hellomultlan/app/core/helpers/messages.dart';
import 'package:hellomultlan/app/core/helpers/zone.object.dart';
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

  late final TextEditingController _signal;
  TextEditingController get signal => _signal;

  late final TextEditingController _label;
  TextEditingController get label => _label;

  TextEditingController get totalClientsActivatedEC => _totalClientsActivatedEC;

  final ValueSignal<List<TextEditingController>> _listClient = ValueSignal([]);
  List<TextEditingController> get listClient => _listClient.value;

  late final ValueNotifier<String?> _zoneSelectEC;
  ValueNotifier<String?> get zoneEC => _zoneSelectEC;

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
    _note = TextEditingController(text: boxModel.note);
    _signal = TextEditingController(text: boxModel.signal.toString());
    _label = TextEditingController(text: boxModel.label);
    _zoneSelectEC = ValueNotifier<String?>(boxModel.zone);
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
        _label.text,
        int.parse(_totalClientsActivatedEC.text),
        int.parse(_totalClientsEC.text),
        List.generate(
            _listClient.value.length, (index) => _listClient.value[index].text),
        num.parse(_signal.value.text),
        _note.text,
        _zoneSelectEC.value!,
      );
      loader(false);
    }
  }

  Future<void> _saveBox(String label, int filledSpace, int freeSpace,
      List<String> listUser, num signal, String note, String zone) async {
    if (filledSpace > listClient.length) {
      showError(
          "Quantidade de Nome de Clientes deve ser igual ao número de clientes ativos");
      return;
    }

    final zoneCod =
        zoneObject.where((element) => element["label"] == zone).first;

    final updatedBox = (
      label: label,
      filledSpace: filledSpace,
      freeSpace: freeSpace,
      id: _boxModel.value!.id,
      signal: _boxModel.value!.signal,
      listClient: listUser,
      note: note,
      zone: zoneCod["cod"]!
    );
    final result = await _gateway.saveBox(updatedBox);
    switch (result) {
      case Sucess(:final value):
        final BoxModel(:updatedAt) = value;
        _boxModel.set(
            _boxModel.value!.updatedBox(
              label,
              filledSpace,
              freeSpace,
              listUser,
              signal,
              note,
              zone,
              updatedAt,
            ),
            force: true);

        showSuccess("Sucesso em Salvar a Caixa");
      case Failure(exception: GatewayException(message: String message)):
        showError(message);
    }
  }
}
