import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hellomultlan/app/core/either/either.dart';
import 'package:hellomultlan/app/core/exceptions/gateway_exception.dart';
import 'package:hellomultlan/app/core/exceptions/geolocator_service_exception.dart';
import 'package:hellomultlan/app/core/exceptions/image_picker_service_exception.dart';
import 'package:hellomultlan/app/core/helpers/loader.dart';
import 'package:hellomultlan/app/core/helpers/messages.dart';
import 'package:hellomultlan/app/core/services/geolocator_service.dart';
import 'package:hellomultlan/app/core/services/image_picker_service.dart';
import 'package:hellomultlan/app/modules/box/gateway/box_gateway.dart';
import 'package:signals_flutter/signals_flutter.dart';

class BoxFormController with MessageStateMixin, LoaderControllerMixin {
  final BoxGateway _gateway;
  final ImagePickerService _imagePickerService;
  final GeolocatorService _geolocatorService;

  final _fileImage = ValueSignal<File>(File(""));
  File get fileImage => _fileImage();
  final ValueNotifier<List<TextEditingController>> listClient =
      ValueNotifier<List<TextEditingController>>([]);
  final selectedGps = ValueSignal<List<bool>>([true, false]);

  double _latitude = 0.0;
  double _longitude = 0.0;

  void dispose() {
    _fileImage.dispose();
    selectedGps.dispose();
    listClient.dispose();
  }

  BoxFormController(
      {required BoxGateway gateway,
      required ImagePickerService imagePickerService,
      required GeolocatorService geolocatorService})
      : _gateway = gateway,
        _imagePickerService = imagePickerService,
        _geolocatorService = geolocatorService;

  Future<void> getImage() async {
    try {
      _fileImage.forceUpdate(await _imagePickerService.getImage());
    } on ImagePickerServiceException catch (e) {
      showError(e.message);
    }
  }

  Future<void> sendBox(
    String label,
    int filledSpace,
    int freeSpace,
    num signal,
    String address,
    String zone,
  ) async {
    if (fileImage.path.isEmpty) {
      showInfo("Selecione uma imagem");
      return;
    }
    if (filledSpace > listClient.value.length) {
      showError(
          "Quantidade de Nome de Clientes deve ser igual ao número de clientes ativos");
      return;
    }
    loader(true);
    if (selectedGps.value[0]) {
      await getLocation();
    } else {
      await getLocationByAddres(address);
    }
    final boxSaved = (
      label: label,
      filledSpace: filledSpace,
      freeSpace: freeSpace,
      latitude: _latitude,
      longitude: _longitude,
      signal: signal,
      zone: zone,
      listUser: List.generate(
          listClient.value.length, (index) => listClient.value[index].text),
      file: fileImage
    );

    final result = await _gateway.createBox(boxSaved);

    loader(false);
    switch (result) {
      case Failure(exception: GatewayException(message: final message)):
        showError(message);
      case Sucess():
        showSuccess("Caixa Criada com Sucesso");
    }
  }

  Future<void> getLocation() async {
    try {
      final Position(:latitude, :longitude) =
          await _geolocatorService.determinePosition();
      _latitude = latitude;
      _longitude = longitude;
    } on GeolocatorServiceException catch (e, s) {
      log(e.message, error: e, stackTrace: s);
      showError(e.message);
    }
  }

  void addNewClient() {
    listClient.value = [...listClient.value, TextEditingController()];
  }

  void removeClient(int index) {
    final updatedList = [...listClient.value];
    updatedList[index].dispose();
    updatedList.removeAt(index);
    listClient.value = updatedList;
  }

  Future<void> getLocationByAddres(String address) async {
    try {
      final Location(:latitude, :longitude) =
          await _geolocatorService.determinePositionByAddress(address);
      _latitude = latitude;
      _longitude = longitude;
    } on GeolocatorServiceException catch (e, s) {
      log(e.message, error: e, stackTrace: s);
      showError(e.message);
    }
  }
}
