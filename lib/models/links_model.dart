import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'links_model.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class Links extends Equatable {
  const Links({
    required this.mediumImage,
    required this.largeImage,
  });

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);
  final Link? mediumImage;
  final Link? largeImage;

  @override
  List<Object?> get props => [
        mediumImage,
        largeImage,
      ];
}

@JsonSerializable(explicitToJson: true, createToJson: false)
class Link extends Equatable {
  const Link({
    required this.href,
  });

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);
  final String href;

  @override
  List<Object?> get props => [
        href,
      ];
}
