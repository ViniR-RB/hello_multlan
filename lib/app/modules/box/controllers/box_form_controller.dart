import 'dart:developer';
import 'dart:io';

import 'package:asyncstate/asyncstate.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hellomultlan/app/core/either/either.dart';
import 'package:hellomultlan/app/core/exceptions/gateway_exception.dart';
import 'package:hellomultlan/app/core/exceptions/geolocator_service_exception.dart';
import 'package:hellomultlan/app/core/exceptions/image_picker_service_exception.dart';
import 'package:hellomultlan/app/core/helpers/messages.dart';
import 'package:hellomultlan/app/core/services/geolocator_service.dart';
import 'package:hellomultlan/app/core/services/image_picker_service.dart';
import 'package:hellomultlan/app/modules/box/gateway/box_gateway.dart';
import 'package:signals_flutter/signals_flutter.dart';

class BoxFormController with MessageStateMixin {
  final BoxGateway _gateway;
  final ImagePickerService _imagePickerService;
  final GeolocatorService _geolocatorService;
  final _fileImage = ValueSignal<File>(File(""));
  File get fileImage => _fileImage();
  final ValueSignal<List<TextEditingController>> listClient =
      ValueSignal<List<TextEditingController>>([]);
  final selectedGps = ValueSignal<List<bool>>([true, false]);

  double _latitude = 0.0;
  double _longitude = 0.0;

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
    int filledSpace,
    int freeSpace,
    String address,
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
    if (selectedGps.value[0]) {
      await getLocation();
    } else {
      await getLocationByAddres(address);
    }
    final boxSaved = (
      filledSpace: filledSpace,
      freeSpace: freeSpace,
      latitude: _latitude,
      longitude: _longitude,
      listUser: List.generate(
          listClient.value.length, (index) => listClient.value[index].text),
      file: fileImage
    );
    final result = await _gateway.saveBox(boxSaved).asyncLoader();

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
    listClient.forceUpdate([...listClient.value, TextEditingController()]);
  }

  void removeClient(int index) {
    listClient.value.removeAt(index);
    listClient.set(force: true, [...listClient.value]);
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
