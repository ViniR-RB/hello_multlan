import 'package:flutter/material.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

class CustomLocationLayer extends StatelessWidget {
  const CustomLocationLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return CurrentLocationLayer(
      style: const LocationMarkerStyle(
        marker: DefaultLocationMarker(
          child: Icon(
            Icons.navigation,
            color: Colors.white,
          ),
        ),
        markerSize: Size(40, 40),
        markerDirection: MarkerDirection.heading,
      ),
    );
  }
}
