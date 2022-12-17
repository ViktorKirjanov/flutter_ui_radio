import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_radio/blocs/stations_bloc/stations_bloc.dart';
import 'package:flutter_ui_radio/config/custom_theme.dart';

class AppBarLoader extends StatelessWidget {
  const AppBarLoader({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<StationsBloc, StationsState>(
        builder: (context, state) {
          if (state.isLoading && state.stations.isNotEmpty) {
            return const Padding(
              padding: EdgeInsets.only(right: CustomTheme.mainSpacing),
              child: Center(
                child: SizedBox(
                  height: 24.0,
                  width: 24.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      );
}
