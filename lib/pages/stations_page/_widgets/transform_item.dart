import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_ui_radio/pages/stations_page/_widgets/station_card/station_card.dart';

class TransformItem extends StatelessWidget {
  const TransformItem({
    super.key,
    required this.stationCard,
    required this.itemHeight,
    required this.factorChange,
    this.scale = 1.0,
    this.endScale = 1.0,
    this.translateY = 0.0,
    this.endTranslateY = 0.0,
  });

  final StationCard stationCard;
  final double itemHeight;
  final double factorChange;
  final double scale;
  final double endScale;
  final double translateY;
  final double endTranslateY;

  @override
  Widget build(BuildContext context) => Transform(
        alignment: Alignment.topCenter,
        transform: Matrix4.identity()
          ..scale(
            lerpDouble(scale, endScale, factorChange),
          )
          ..translate(
            0.0,
            lerpDouble(translateY, endTranslateY, factorChange)!,
            0.0,
          ),
        child: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: itemHeight,
            width: double.infinity,
            child: stationCard,
          ),
        ),
      );
}
