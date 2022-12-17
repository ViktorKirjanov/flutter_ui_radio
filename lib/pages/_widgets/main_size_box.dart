import 'package:flutter/material.dart';
import 'package:flutter_ui_radio/config/custom_theme.dart';

class MainSizeBox extends StatelessWidget {
  const MainSizeBox({super.key});

  @override
  Widget build(BuildContext context) =>
      const SizedBox(height: CustomTheme.mainSpacing);
}
