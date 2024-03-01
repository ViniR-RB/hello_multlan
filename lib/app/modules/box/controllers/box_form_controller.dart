import 'dart:developer';
import 'dart:io';

import 'package:asyncstate/asyncstate.dart';
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

  Future<void> sendBox(int activatedClient, File imageFile, String reference,
      int totalClient) async {
    if (imageFile.path.isEmpty) {
      showInfo("Selecione uma imagem");
    }
    final boxSaved = (
      reference: reference,
      activatedClient: activatedClient,
      imageFile: imageFile,
      latitude: _latitude,
      longitude: _longitude,
      totalClient: totalClient
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
      _geolocatorService.determinePosition().then((value) => {
            _latitude = value.latitude,
            _longitude = value.longitude,
          });
    } on GeolocatorServiceException catch (e, s) {
      log(e.message, error: e, stackTrace: s);
      showError(e.message);
    }
  }

  Future<void> getLocationByAddres(String address) async {
    try {
      _geolocatorService.determinePositionByAddress(address).then((value) => {
            _latitude = value.latitude,
            _longitude = value.longitude,
          });
    } on GeolocatorServiceException catch (e, s) {
      log(e.message, error: e, stackTrace: s);
      showError(e.message);
    }
  }
}
