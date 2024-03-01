import 'package:asyncstate/asyncstate.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hellomultlan/app/core/either/either.dart';
import 'package:hellomultlan/app/core/exceptions/gateway_exception.dart';
import 'package:hellomultlan/app/core/helpers/messages.dart';
import 'package:hellomultlan/app/core/models/box_model.dart';
import 'package:hellomultlan/app/modules/box/gateway/box_gateway.dart';
import 'package:signals_flutter/signals_flutter.dart';

class BoxMapController with MessageStateMixin {
  final BoxGateway _gateway;

  BoxMapController({required BoxGateway gateway}) : _gateway = gateway;

  final _mapController = ValueSignal<MapController>(MapController());
  MapController get mapController => _mapController();

  final _boxList = ValueSignal<List<BoxModel>>([]);
  List<BoxModel> get boxList => _boxList();

  Future<void> getAllBoxs() async {
    final result = await _gateway.getAllBoxs().asyncLoader();

    switch (result) {
      case Failure(exception: GatewayException(message: final message)):
        showError(message);
      case Sucess(value: final value):
        _boxList.forceUpdate(value);
    }
  }

  Future<void> editBox(BoxModel model) async {}
}
