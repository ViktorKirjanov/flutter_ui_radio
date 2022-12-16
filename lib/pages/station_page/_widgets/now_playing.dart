import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_radio/blocs/cubit/on_off_cubit.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<OnOffCubit, bool>(
        builder: (_, state) => Text(
          state ? 'Now playing' : 'Paused',
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.grey,
          ),
        ),
      );
}
