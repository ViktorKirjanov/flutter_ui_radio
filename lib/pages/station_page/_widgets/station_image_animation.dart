import 'package:flutter/material.dart';
import 'package:flutter_ui_radio/config/consts.dart';
import 'package:flutter_ui_radio/models/links_model.dart';
import 'package:flutter_ui_radio/pages/station_page/_widgets/blob.dart';
import 'package:flutter_ui_radio/pages/station_page/_widgets/circle_image.dart';

class StationImageAnimation extends StatelessWidget {
  const StationImageAnimation({super.key, this.link});

  final Link? link;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            ...List.filled(
              Animations.audioWaves,
              const AnimatedBlob(),
            ),
            CircleImage(link: link),
          ],
        ),
      );
}
