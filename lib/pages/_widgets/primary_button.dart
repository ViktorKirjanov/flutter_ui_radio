import 'package:flutter/material.dart';
import 'package:flutter_ui_radio/config/custom_theme.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.title,
    this.active = true,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final bool active;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 55.0,
        width: double.infinity,
        child: Opacity(
          opacity: active ? 1.0 : .5,
          child: TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(
                CustomTheme.mainColor,
              ),
              overlayColor: MaterialStateProperty.all(
                CustomTheme.grey.withOpacity(.2),
              ),
              foregroundColor: MaterialStateProperty.all(
                CustomTheme.grey,
              ),
            ),
            onPressed: onPressed,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      );
}
