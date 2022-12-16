import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_radio/blocs/cubit/on_off_cubit.dart';

class ControlButtons extends StatelessWidget {
  const ControlButtons({super.key});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CupertinoButton(
            child: Column(
              children: const [
                Text(
                  'HD',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  'Quality',
                  style: TextStyle(fontSize: 11.0),
                ),
              ],
            ),
            onPressed: () {},
          ),
          Container(
            width: 75,
            height: 75,
            decoration: ShapeDecoration(
              shape: const StadiumBorder(),
              color: Colors.purple.shade300,
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
              children: const [
                Icon(
                  Icons.playlist_play_rounded,
                  size: 30.0,
                  color: Colors.white70,
                ),
                Text(
                  'Playlist',
                  style: TextStyle(fontSize: 11.0),
                ),
              ],
            ),
            onPressed: () {},
          ),
        ],
      );
}
