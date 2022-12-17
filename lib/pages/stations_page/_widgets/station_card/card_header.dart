import 'package:flutter/material.dart';
import 'package:flutter_ui_radio/pages/stations_page/_widgets/station_card/sound_indicator.dart';

class CardHeader extends StatelessWidget {
  const CardHeader({
    super.key,
    required this.color,
    required this.index,
    required this.total,
    required this.name,
  });

  final Color color;
  final int index;
  final int total;
  final String name;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.only(top: 10.0),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              if (index % 3 == 0)
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: SoundIndicator(),
                ),
              Expanded(
                child: Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                '${index + 1}/$total',
                style: const TextStyle(
                  fontSize: 10.0,
                ),
              ),
            ],
          ),
        ),
      );
}
