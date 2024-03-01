import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hellomultlan/app/core/configuration/configuration.dart';
import 'package:hellomultlan/app/core/either/either.dart';
import 'package:hellomultlan/app/core/either/unit.dart';
import 'package:hellomultlan/app/core/exceptions/gateway_exception.dart';
import 'package:hellomultlan/app/core/models/box_model.dart';
import 'package:hellomultlan/app/core/rest_client/rest_client.dart';
import 'package:hellomultlan/app/modules/box/dto/create_box_dto.dart';

import './box_gateway.dart';

class BoxGatewayImpl implements BoxGateway {
  final RestClient _restClient;

  BoxGatewayImpl({required RestClient restClient}) : _restClient = restClient;
  @override
  Future<Either<Unit, GatewayException>> saveBox(CreateBoxDto boxSaved) async {
    try {
      final CreateBoxDto(
        imageFile: imageFile,
        activatedClient: activatedClient,
        totalClient: totalClient,
        latitude: latitude,
        longitude: longitude,
        reference: reference,
      ) = boxSaved;
      final Response(:data as Map) = await _restClient.auth.post("uploads",
          data: FormData.fromMap({
            "file": await MultipartFile.fromFile(
              imageFile.path,
              filename: "image.png",
            ),
          }));
      final String image =
          Configuration.baseUrl.substring(0, Configuration.baseUrl.length - 1) +
              data['url'];
      await _restClient.auth.post(
        "boxs",
        data: {
          'reference': reference,
          'activated_client': activatedClient,
          'total_client': totalClient,
          'latitude': latitude,
          'longitude': longitude,
          "image": image
        },
      );

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
      final Response(:data as List) = await _restClient.auth.get("boxs");
      final List<BoxModel> boxList =
          data.map((e) => BoxModel.fromMap(e)).toList();
      return Sucess(boxList);
    } on DioException catch (e, s) {
      const message = "Erro ao buscar todas as caixas";
      log(message, error: e, stackTrace: s);
      return Failure(GatewayException(message));
    }
  }
}
