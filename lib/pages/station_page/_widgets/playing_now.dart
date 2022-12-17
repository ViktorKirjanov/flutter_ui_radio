import 'package:flutter/material.dart';
import 'package:flutter_ui_radio/config/custom_theme.dart';

class PlayingNow extends StatelessWidget {
  const PlayingNow({super.key});

  @override
  Widget build(BuildContext context) => Text(
        'Disturbed - Unstoppable',
        style: CustomTheme.header2,
      );
}
