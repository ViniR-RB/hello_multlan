import 'package:hellomultlan/app/core/either/either.dart';
import 'package:hellomultlan/app/core/either/unit.dart';
import 'package:hellomultlan/app/core/exceptions/gateway_exception.dart';
import 'package:hellomultlan/app/core/models/box_model.dart';
import 'package:hellomultlan/app/modules/box/dto/create_box_dto.dart';
import 'package:hellomultlan/app/modules/box/dto/updated_box_dto.dart';

abstract interface class BoxGateway {
  Future<Either<Unit, GatewayException>> createBox(CreateBoxDto boxSaved);
  Future<Either<List<BoxModel>, GatewayException>> getAllBoxs();
  Future<Either<BoxModel, GatewayException>> saveBox(UpdatedBoxDto updatedBox);
}
