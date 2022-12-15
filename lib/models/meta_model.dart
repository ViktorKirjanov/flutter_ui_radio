import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meta_model.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class Meta extends Equatable {
  const Meta({
    required this.totalCount,
    required this.returnedCount,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
  final int totalCount;
  final int returnedCount;

  @override
  List<Object?> get props => [
        totalCount,
        returnedCount,
      ];
}
