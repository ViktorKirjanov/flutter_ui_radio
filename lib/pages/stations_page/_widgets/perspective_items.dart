import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_ui_radio/pages/stations_page/_widgets/station_card/station_card.dart';
import 'package:flutter_ui_radio/pages/stations_page/_widgets/transform_item.dart';

class PerspectiveItems extends StatelessWidget {
  const PerspectiveItems({
    super.key,
    required this.visualizedCount,
    required this.currentIndex,
    required this.itemHeight,
    required this.pagePersent,
    required this.children,
  });

  final int visualizedCount;
  final int currentIndex;
  final double itemHeight;
  final double pagePersent;
  final List<StationCard> children;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final layoutHeight = constraints.maxHeight;

          return Stack(
            fit: StackFit.expand,
            children: List.generate(visualizedCount, (index) {
              final invertedIndex = (visualizedCount - 2) - index;
              final indexPlus = index + 1;
              final positionPersent = indexPlus / visualizedCount;
              final endPositionPersent = index / visualizedCount;

              return (currentIndex > invertedIndex)
                  ? TransformItem(
                      stationCard: children[currentIndex - (invertedIndex + 1)],
                      itemHeight: itemHeight,
                      factorChange: pagePersent,
                      scale: lerpDouble(.6, 1.0, positionPersent)!,
                      endScale: lerpDouble(.6, 1.0, endPositionPersent)!,
                      translateY: (layoutHeight - itemHeight) * positionPersent,
                      endTranslateY:
                          (layoutHeight - itemHeight) * endPositionPersent,
                    )
                  : const SizedBox();
            })
              // Bottom card
              ..add(
                (currentIndex < children.length - 1)
                    ? TransformItem(
                        stationCard: children[currentIndex + 1],
                        itemHeight: itemHeight,
                        factorChange: pagePersent,
                        translateY: layoutHeight + 20,
                        endTranslateY: (layoutHeight - itemHeight),
                      )
                    : const SizedBox(),
              )
              // Top item
              ..insert(
                0,
                (currentIndex > (visualizedCount - 1))
                    ? TransformItem(
                        stationCard: children[currentIndex - visualizedCount],
                        itemHeight: itemHeight,
                        factorChange: 1.0,
                        endScale: .6,
                      )
                    : const SizedBox(),
              ),
          );
        },
      );
}
