import 'package:flutter/material.dart';

class SoundIndicator extends StatefulWidget {
  const SoundIndicator({Key? key}) : super(key: key);

  @override
  State<SoundIndicator> createState() => _SoundIndicatorState();
}

class _SoundIndicatorState extends State<SoundIndicator>
    with TickerProviderStateMixin {
  late AnimationController _animation;

  @override
  void initState() {
    super.initState();

    _animation = AnimationController(
      vsync: this,
      lowerBound: 2,
      upperBound: 10,
      duration: const Duration(milliseconds: 200),
    )..repeat(reverse: true);

    _animation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Row(
        children: List.generate(
          4,
          (index) => Container(
            margin: const EdgeInsets.only(left: 1, right: 1),
            width: 3,
            height: index % 2 == 0 ? _animation.value : 10 - _animation.value,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
      );
}
