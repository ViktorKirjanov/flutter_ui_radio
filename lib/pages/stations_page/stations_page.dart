import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_radio/blocs/stations_bloc/stations_bloc.dart';
import 'package:flutter_ui_radio/config/consts.dart';
import 'package:flutter_ui_radio/config/custom_theme.dart';
import 'package:flutter_ui_radio/networking/repository/station_repository.dart';
import 'package:flutter_ui_radio/pages/_widgets/main_size_box.dart';
import 'package:flutter_ui_radio/pages/_widgets/primary_button.dart';
import 'package:flutter_ui_radio/pages/station_page/station_page.dart';
import 'package:flutter_ui_radio/pages/stations_page/_widgets/appbar_loader.dart';
import 'package:flutter_ui_radio/pages/stations_page/_widgets/perspective_list_view.dart';
import 'package:flutter_ui_radio/pages/stations_page/_widgets/station_card/station_card.dart';

class StationsPage extends StatelessWidget {
  const StationsPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => StationsBloc(
          stationRepository: context.read<StationRepository>(),
        )..add(const FirstStationsEvent()),
        child: Scaffold(
          appBar: AppBar(
            actions: const [AppBarLoader()],
          ),
          extendBodyBehindAppBar: true,
          body: const _StationsView(),
        ),
      );
}

class _StationsView extends StatefulWidget {
  const _StationsView();

  @override
  State<_StationsView> createState() => __StationsViewState();
}

class __StationsViewState extends State<_StationsView> {
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<StationsBloc, StationsState>(
        builder: (_, state) {
          if (state.isLoading && state.stations.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.stations.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(CustomTheme.mainSpacing),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Sorry, list is empty...'),
                  const MainSizeBox(),
                  PrimaryButton(
                    title: 'Refresh',
                    onPressed: () => context.read<StationsBloc>().add(
                          const FirstStationsEvent(),
                        ),
                  ),
                ],
              ),
            );
          } else if (state.stations.isNotEmpty) {
            return RefreshIndicator(
              color: CustomTheme.black,
              child: PerspectiveListView(
                itemExtent: MediaQuery.of(context).size.width,
                visualizedCount: StationList.visualizedCount,
                initialIndex: StationList.initialIndex,
                padding: EdgeInsets.fromLTRB(
                  CustomTheme.mainSpacing,
                  AppBar().preferredSize.height,
                  CustomTheme.mainSpacing,
                  CustomTheme.mainSpacing,
                ),
                children: List.generate(
                  state.stations.length,
                  (index) => StationCard(
                    station: state.stations[index],
                    index: index,
                    total: state.total,
                  ),
                ),
                onChangeItem: (int index) {
                  log('onChangeItem: $index / ${state.stations.length}');
                  if (index == state.stations.length - 5 &&
                      state.hasMorePages) {
                    context.read<StationsBloc>().add(const NextStationsEvent());
                  }
                },
                onTapFrontItem: (int index) {
                  log('onTapFrontItem: $index');
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => StationPage(
                        station: state.stations[index],
                      ),
                    ),
                  );
                },
              ),
              onRefresh: () async {
                context.read<StationsBloc>().add(const FirstStationsEvent());
              },
            );
          } else if (state.error != null) {
            return Padding(
              padding: const EdgeInsets.all(CustomTheme.mainSpacing),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.error!),
                  const MainSizeBox(),
                  PrimaryButton(
                    title: 'Refresh',
                    onPressed: () => context.read<StationsBloc>().add(
                          const FirstStationsEvent(),
                        ),
                  ),
                ],
              ),
            );
          }

          return const Center(
            child: Text('Ooops, something went wrong'),
          );
        },
      );
}
