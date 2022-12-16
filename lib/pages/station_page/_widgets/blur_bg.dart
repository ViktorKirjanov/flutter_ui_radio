import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_ui_radio/models/links_model.dart';

class BlurBG extends StatelessWidget {
  const BlurBG({super.key, required this.link});

  final Link? link;

  @override
  Widget build(BuildContext context) => ClipRRect(
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: link != null
                ? DecorationImage(
                    image: NetworkImage(link!.href),
                    fit: BoxFit.cover,
                  )
                : null,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.purple,
                Colors.blue,
              ],
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 50.0,
              sigmaY: 50.0,
            ),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        ),
      );
}
