import 'dart:convert';

class BoxModel {
  final String reference;
  final int activatedClient;
  final int totalClient;
  final double latitude;
  final double longitude;
  final String imageUrl;
  BoxModel(
      {required this.reference,
      required this.activatedClient,
      required this.totalClient,
      required this.latitude,
      required this.longitude,
      this.imageUrl = ""});

  BoxModel copyWith({
    String? reference,
    int? activatedClient,
    int? totalClient,
    double? latitude,
    double? longitude,
  }) {
    return BoxModel(
      reference: reference ?? this.reference,
      activatedClient: activatedClient ?? this.activatedClient,
      totalClient: totalClient ?? this.totalClient,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reference': reference,
      'activated_client': activatedClient,
      'total_client': totalClient,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory BoxModel.fromMap(Map<String, dynamic> map) {
    return switch (map) {
      {
        "reference": final String reference,
        "activated_client": final int activatedClient,
        "total_client": final int totalClient,
        "latitude": final double latitude,
        "longitude": final double longitude,
        "image": final String imageUrl,
      } =>
        BoxModel(
          reference: reference,
          activatedClient: activatedClient,
          totalClient: totalClient,
          latitude: latitude,
          longitude: longitude,
          imageUrl: imageUrl,
        ),
      _ => throw ArgumentError('Invalid map $map')
    };
  }

  String toJson() => json.encode(toMap());

  factory BoxModel.fromJson(String source) =>
      BoxModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BoxModel(reference: $reference, activatedClient: $activatedClient, totalClient: $totalClient, latitude: $latitude, longitude: $longitude)';
  }
}
