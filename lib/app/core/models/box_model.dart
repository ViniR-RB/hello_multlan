import 'dart:convert';

import 'package:flutter/foundation.dart';

class BoxModel {
  final String id;
  String label;
  final String latitude;
  final String longitude;
  List<String> listUsers;
  String? note;
  int freeSpace;
  int filledSpace;
  num signal;
  final String createdAt;
  String updatedAt;
  String zone;
  final String image;

  BoxModel({
    required this.id,
    required this.label,
    required this.latitude,
    required this.longitude,
    required this.listUsers,
    this.note = "",
    required this.signal,
    required this.freeSpace,
    required this.filledSpace,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
    required this.zone,
  });

  BoxModel copyWith({
    String? id,
    String? label,
    String? latitude,
    String? longitude,
    List<String>? listUsers,
    String? note,
    num? signal,
    int? freeSpace,
    int? filledSpace,
    String? createdAt,
    String? updatedAt,
    String? image,
    String? zone,
  }) {
    return BoxModel(
      id: id ?? this.id,
      label: label ?? this.label,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      listUsers: listUsers ?? this.listUsers,
      note: note ?? this.note,
      signal: signal ?? this.signal,
      freeSpace: freeSpace ?? this.freeSpace,
      filledSpace: filledSpace ?? this.filledSpace,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      image: image ?? this.image,
      zone: zone ?? this.zone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      "label": label,
      'latitude': latitude,
      'longitude': longitude,
      'listUsers': listUsers,
      "note": note,
      "signal": signal,
      'freeSpace': freeSpace,
      'filledSpace': filledSpace,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'image': image,
      "zone": zone,
    };
  }

  BoxModel updatedBox(
      String label,
      int filledSpace,
      int freeSpace,
      List<String> listUser,
      num signal,
      String note,
      String zone,
      String updatedAt) {
    this.label = label;
    this.filledSpace = filledSpace;
    this.freeSpace = freeSpace;
    listUsers = listUser;
    this.note = note;
    this.updatedAt = updatedAt;
    this.signal = signal;
    this.zone = zone;
    return this;
  }

  factory BoxModel.fromMap(Map map) {
    return switch (map) {
      {
        "id": final String id,
        "label": final String label,
        "latitude": final String latitude,
        "longitude": final String longitude,
        "freeSpace": final int freeSpace,
        "filledSpace": final int filledSpace,
        "listUser": final List listUser,
        "note": final String note,
        "signal": final num signal,
        "createdAt": final String createdAt,
        "updatedAt": final String updatedAt,
        "image": final String image,
        "zone": final String zone,
      } =>
        BoxModel(
          id: id,
          label: label,
          latitude: latitude,
          longitude: longitude,
          listUsers: listUser.map((e) => e.toString()).toList(),
          note: note,
          signal: signal.toDouble(),
          freeSpace: freeSpace,
          filledSpace: filledSpace,
          createdAt: createdAt,
          updatedAt: updatedAt,
          image: image,
          zone: switch (zone) {
            "SAFE" => "Zona Segura",
            "MODERATE" => "Zona Média",
            "DANGER" => "Zona Perigosa",
            _ => "Zona desconhecida"
          },
        ),
      _ => throw ArgumentError("Erro ao Transformar a BoxModel")
    };
  }

  String toJson() => json.encode(toMap());

  factory BoxModel.fromJson(String source) =>
      BoxModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BoxModel(id: $id, latitude: $latitude, longitude: $longitude, listUsers: $listUsers,"note": $note, freeSpace: $freeSpace, filledSpace: $filledSpace, createdAt: $createdAt, updatedAt: $updatedAt, image: $image)';
  }

  @override
  bool operator ==(covariant BoxModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        listEquals(other.listUsers, listUsers) &&
        other.note == note &&
        other.freeSpace == freeSpace &&
        other.filledSpace == filledSpace &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        listUsers.hashCode ^
        note.hashCode ^
        freeSpace.hashCode ^
        filledSpace.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        image.hashCode ^
        zone.hashCode;
  }
}
