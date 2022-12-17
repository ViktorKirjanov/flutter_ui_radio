import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_radio/blocs/cubit/on_off_cubit.dart';
import 'package:flutter_ui_radio/config/custom_theme.dart';

class ControlButtons extends StatelessWidget {
  const ControlButtons({super.key});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CupertinoButton(
            child: Column(
              children: [
                Text(
                  'HD',
                  style: CustomTheme.header1,
                ),
                const SizedBox(height: 2.0),
                Text(
                  'Quality',
                  style: CustomTheme.small,
                ),
              ],
            ),
            onPressed: () {},
          ),
          Container(
            width: 75,
            height: 75,
            decoration: const ShapeDecoration(
              shape: StadiumBorder(),
              color: CustomTheme.mainColor,
            ),
            child: BlocBuilder<OnOffCubit, bool>(
              builder: (_, state) => MaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: const StadiumBorder(),
                child: Icon(
                  state ? CupertinoIcons.play_arrow : CupertinoIcons.stop,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: () => context.read<OnOffCubit>().onoff(),
              ),
            ),
          ),
          CupertinoButton(
            child: Column(
              children: [
                const Icon(
                  Icons.playlist_play_rounded,
                  size: 30.0,
                  color: Colors.white70,
                ),
                Text(
                  'Playlist',
                  style: CustomTheme.small,
                ),
              ],
            ),
            onPressed: () {},
          ),
        ],
      );
}
