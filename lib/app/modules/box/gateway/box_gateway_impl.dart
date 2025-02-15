import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hellomultlan/app/core/either/either.dart';
import 'package:hellomultlan/app/core/either/unit.dart';
import 'package:hellomultlan/app/core/exceptions/gateway_exception.dart';
import 'package:hellomultlan/app/core/models/box_model.dart';
import 'package:hellomultlan/app/core/rest_client/rest_client.dart';
import 'package:hellomultlan/app/modules/box/dto/create_box_dto.dart';
import 'package:hellomultlan/app/modules/box/dto/updated_box_dto.dart';

import './box_gateway.dart';

class BoxGatewayImpl implements BoxGateway {
  final RestClient _restClient;

  BoxGatewayImpl({required RestClient restClient}) : _restClient = restClient;
  @override
  Future<Either<Unit, GatewayException>> createBox(
      CreateBoxDto boxSaved) async {
    try {
      final CreateBoxDto(
        :label,
        :filledSpace,
        :freeSpace,
        :latitude,
        :longitude,
        :signal,
        :file,
        :listUser,
        :zone
      ) = boxSaved;
      final formData = FormData.fromMap({
        "label": label,
        "filledSpace": filledSpace,
        "freeSpace": freeSpace,
        "latitude": latitude,
        "longitude": longitude,
        "listUser": listUser,
        "signal": signal,
        "zone": zone,
        "file": await MultipartFile.fromFile(file.path,
            filename: file.uri.toString()),
      });
      await _restClient.auth.post("api/box",
          data: formData,
          options: Options(headers: {
            'Content-Type': 'multipart/form-data',
          }));

      return Sucess(unit);
    } on DioException catch (e, s) {
      const message = "Não foi possível salvar a caixa";
      log(message, error: e, stackTrace: s);
      return Failure(GatewayException(message));
    }
  }

  @override
  Future<Either<List<BoxModel>, GatewayException>> getAllBoxs() async {
    try {
      final Response(:data as List) = await _restClient.auth.get("/api/box");
      final List<BoxModel> boxList =
          data.map((e) => BoxModel.fromMap(e)).toList();
      return Sucess(boxList);
    } on DioException catch (e, s) {
      const message = "Erro ao buscar todas as caixas";
      log(message, error: e, stackTrace: s);
      return Failure(GatewayException(message));
    }
  }

  @override
  Future<Either<BoxModel, GatewayException>> saveBox(
      UpdatedBoxDto updatedBox) async {
    try {
      final UpdatedBoxDto(
        :id,
        :filledSpace,
        :freeSpace,
        :listClient,
        :signal,
        :label,
        :zone
      ) = updatedBox;
      final Response(:data) = await _restClient.auth.put("/api/box/$id", data: {
        "label": label,
        "filledSpace": filledSpace,
        "freeSpace": freeSpace,
        "signal": double.parse(signal.toString()),
        "listUser": listClient,
        "zone": zone,
      });
      final boxModel = BoxModel.fromMap(data);
      return Sucess(boxModel);
    } on DioException catch (e, s) {
      const message = "Erro ao atualiza a caixas";
      log(message, error: e, stackTrace: s);
      return Failure(GatewayException(message));
    }
  }
}
