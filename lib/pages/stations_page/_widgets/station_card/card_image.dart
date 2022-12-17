import 'package:flutter/material.dart';
import 'package:flutter_ui_radio/models/links_model.dart';

class CardImage extends StatelessWidget {
  const CardImage({
    super.key,
    required this.artists,
    required this.link,
  });

  final String artists;
  final Link? link;

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(16.0),
        ),
        child: Stack(
          children: [
            SizedBox.expand(
              child: link != null
                  ? Image.network(
                      link!.href,
                      fit: BoxFit.cover,
                      frameBuilder: (context, child, frame, _) {
                        if (frame == null) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return child;
                      },
                    )
                  : Container(),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(.75),
                    Colors.black.withOpacity(.0),
                    Colors.black.withOpacity(.75),
                  ],
                  stops: const [.1, .5, .9],
                ),
              ),
            ),
          ],
        ),
      );
}
