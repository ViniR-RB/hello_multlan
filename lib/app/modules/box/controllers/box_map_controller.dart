import 'package:flutter_map/flutter_map.dart';
import 'package:hellomultlan/app/core/either/either.dart';
import 'package:hellomultlan/app/core/exceptions/gateway_exception.dart';
import 'package:hellomultlan/app/core/helpers/loader.dart';
import 'package:hellomultlan/app/core/helpers/messages.dart';
import 'package:hellomultlan/app/core/models/box_model.dart';
import 'package:hellomultlan/app/modules/box/gateway/box_gateway.dart';
import 'package:signals_flutter/signals_flutter.dart';

class BoxMapController with MessageStateMixin, LoaderControllerMixin {
  final BoxGateway _gateway;

  BoxMapController({required BoxGateway gateway}) : _gateway = gateway;

  final _mapController = ValueSignal<MapController>(MapController());
  MapController get mapController => _mapController();

  final _boxList = ValueSignal<List<BoxModel>>([]);
  List<BoxModel> get boxList => _boxList();

  Future<void> getAllBoxs() async {
    loader(true);
    final result = await _gateway.getAllBoxs();

    switch (result) {
      case Failure(exception: GatewayException(message: final message)):
        showError(message);
        loader(false);
      case Sucess(value: final value):
        _boxList.set(value, force: true);
        loader(false);
    }
  }

  Future<void> editBox(BoxModel model) async {}
}
