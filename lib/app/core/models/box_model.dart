import 'dart:convert';

import 'package:flutter/foundation.dart';

class BoxModel {
  final String id;
  final String latitude;
  final String longitude;
  final List<String> listUsers;
  final int freeSpace;
  final int filledSpace;
  final String createdAt;
  final String updatedAt;
  final String image;

  BoxModel({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.listUsers,
    required this.freeSpace,
    required this.filledSpace,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
  });

  BoxModel copyWith({
    String? id,
    String? latitude,
    String? longitude,
    List<String>? listUsers,
    int? freeSpace,
    int? filledSpace,
    String? createdAt,
    String? updatedAt,
    String? image,
  }) {
    return BoxModel(
      id: id ?? this.id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      listUsers: listUsers ?? this.listUsers,
      freeSpace: freeSpace ?? this.freeSpace,
      filledSpace: filledSpace ?? this.filledSpace,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'listUsers': listUsers,
      'freeSpace': freeSpace,
      'filledSpace': filledSpace,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'image': image,
    };
  }

  factory BoxModel.fromMap(Map map) {
    return switch (map) {
      {
        "id": final String id,
        "latitude": final String latitude,
        "longitude": final String longitude,
        "freeSpace": final int freeSpace,
        "filledSpace": final int filledSpace,
        "listUser": final List listUser,
        "createdAt": final String createdAt,
        "updatedAt": final String updatedAt,
        "image": final String image,
      } =>
        BoxModel(
            id: id,
            latitude: latitude,
            longitude: longitude,
            listUsers: listUser.map((e) => e.toString()).toList(),
            freeSpace: freeSpace,
            filledSpace: filledSpace,
            createdAt: createdAt,
            updatedAt: updatedAt,
            image: image),
      _ => throw ArgumentError("Erro ao Transformar a BoxModel")
    };
  }

  String toJson() => json.encode(toMap());

  factory BoxModel.fromJson(String source) =>
      BoxModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BoxModel(id: $id, latitude: $latitude, longitude: $longitude, listUsers: $listUsers, freeSpace: $freeSpace, filledSpace: $filledSpace, createdAt: $createdAt, updatedAt: $updatedAt, image: $image)';
  }

  @override
  bool operator ==(covariant BoxModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        listEquals(other.listUsers, listUsers) &&
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
        freeSpace.hashCode ^
        filledSpace.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        image.hashCode;
  }
}
