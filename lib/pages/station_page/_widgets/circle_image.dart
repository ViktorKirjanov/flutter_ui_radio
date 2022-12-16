import 'package:flutter/material.dart';
import 'package:flutter_ui_radio/models/links_model.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({super.key, this.link});

  final Link? link;

  @override
  Widget build(BuildContext context) => Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .6,
          height: MediaQuery.of(context).size.width * .6,
          child: ClipOval(
            child: link != null
                ? Image.network(
                    link!.href,
                    fit: BoxFit.cover,
                    frameBuilder: (context, child, frame, _) {
                      if (frame == null) {
                        return const CircularProgressIndicator();
                      }
                      return child;
                    },
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.width * .6,
                    width: MediaQuery.of(context).size.width * .6,
                    child: Image.asset('assets/images/vinyl.png'),
                  ),
          ),
        ),
      );
}
