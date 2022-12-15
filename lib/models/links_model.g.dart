// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'links_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Links _$LinksFromJson(Map<String, dynamic> json) => Links(
      mediumImage: json['mediumImage'] == null
          ? null
          : Link.fromJson(json['mediumImage'] as Map<String, dynamic>),
      largeImage: json['largeImage'] == null
          ? null
          : Link.fromJson(json['largeImage'] as Map<String, dynamic>),
    );

Link _$LinkFromJson(Map<String, dynamic> json) => Link(
      href: json['href'] as String,
    );
