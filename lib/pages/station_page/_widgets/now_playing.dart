import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_radio/blocs/cubit/on_off_cubit.dart';
import 'package:flutter_ui_radio/config/custom_theme.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<OnOffCubit, bool>(
        builder: (_, state) => Text(
          state ? 'Now playing' : 'Paused',
          style: CustomTheme.small,
        ),
      );
}
