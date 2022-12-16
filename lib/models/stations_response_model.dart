import 'package:equatable/equatable.dart';
import 'package:flutter_ui_radio/models/station_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stations_response_model.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class StationsResponse extends Equatable {
  const StationsResponse({required this.stations});

  factory StationsResponse.fromJson(Map<String, dynamic> json) =>
      _$StationsResponseFromJson(json);
  final List<Station> stations;

  @override
  List<Object?> get props => [stations];
}