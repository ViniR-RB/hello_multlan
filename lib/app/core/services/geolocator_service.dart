import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hellomultlan/app/core/exceptions/geolocator_service_exception.dart';

class GeolocatorService {
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw GeolocatorServiceException(
          'Os serviços de localização estão desativados, por favor Ativio-os');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw GeolocatorServiceException(
            'As permissões de localização foram negadas, por favor nos der permissão para darmos prosseguimento no envio das denúncias');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw GeolocatorServiceException(
          'As permissões de localização são negadas permanentemente, não podemos solicitar permissões. por favor nos der permissão nas configurações do seu dispositivo');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<Location> determinePositionByAddress(String address) async {
    List<Location?> locations = await locationFromAddress(address);
    if (locations.first == null) {
      throw GeolocatorServiceException(
          "Endereço está errado pois não representa nenhuma localização conhecida");
    }
    return locations.first!;
  }
}
