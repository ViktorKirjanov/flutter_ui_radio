import 'package:equatable/equatable.dart';
import 'package:flutter_ui_radio/models/links_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'station_model.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class Station extends Equatable {
  const Station({
    required this.id,
    required this.href,
    required this.name,
    required this.description,
    required this.summary,
    required this.artists,
    required this.links,
  });

  factory Station.fromJson(Map<String, dynamic> json) =>
      _$StationFromJson(json);

  final String id;
  final String href;
  final String name;
  final String description;
  final String summary;
  final String artists;
  final Links links;

  @override
  List<Object?> get props => [
        id,
        href,
        name,
        description,
        summary,
        artists,
        links,
      ];
}
