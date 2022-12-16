// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stations_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationsResponse _$StationsResponseFromJson(Map<String, dynamic> json) =>
    StationsResponse(
      stations: (json['stations'] as List<dynamic>)
          .map((e) => Station.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
