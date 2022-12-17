import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_radio/config/custom_theme.dart';
import 'package:flutter_ui_radio/models/station_model.dart';
import 'package:flutter_ui_radio/pages/stations_page/_widgets/station_card/card_header.dart';
import 'package:flutter_ui_radio/pages/stations_page/_widgets/station_card/card_image.dart';

class StationCard extends StatelessWidget {
  const StationCard({
    super.key,
    required this.index,
    required this.total,
    required this.station,
  });

  final int index;
  final int total;
  final Station station;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: CustomTheme.mainColor,
          borderRadius: CustomTheme.bigBorderRadius,
          boxShadow: [CustomTheme.shadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardHeader(
              color: CustomTheme.mainColor,
              index: index,
              total: total,
              name: station.name,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsetsDirectional.all(8.0),
                child: Stack(
                  children: [
                    SizedBox.expand(
                      child: CardImage(
                        artists: station.artists,
                        link: station.links.largeImage,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(CustomTheme.mainSpacing),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            station.artists,
                            style: CustomTheme.small,
                          ),
                          const Center(
                            child: Icon(
                              CupertinoIcons.play_circle,
                              color: Colors.white54,
                              size: 82.0,
                            ),
                          ),
                          Text(
                            station.summary,
                            style: CustomTheme.small,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
