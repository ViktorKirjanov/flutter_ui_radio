import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';

class AnimatedBlob extends StatelessWidget {
  const AnimatedBlob({super.key});

  @override
  Widget build(BuildContext context) {
    final BlobController blobCtrl = BlobController();
    return SizedBox(
      child: Blob.animatedRandom(
        size: MediaQuery.of(context).size.width,
        controller: blobCtrl,
        loop: true,
        duration: const Duration(milliseconds: 1000),
        styles: BlobStyles(
          color: Colors.white.withOpacity(.15),
          strokeWidth: 2,
          fillType: BlobFillType.stroke,
        ),
      ),
    );
  }
}
