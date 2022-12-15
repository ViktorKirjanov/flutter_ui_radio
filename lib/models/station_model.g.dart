// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Station _$StationFromJson(Map<String, dynamic> json) => Station(
      id: json['id'] as String,
      href: json['href'] as String,
      name: json['name'] as String,
      artists: json['artists'] as String,
      links: Links.fromJson(json['links'] as Map<String, dynamic>),
    );
