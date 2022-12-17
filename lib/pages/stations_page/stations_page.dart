import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_radio/blocs/stations_bloc/stations_bloc.dart';
import 'package:flutter_ui_radio/config/custom_theme.dart';
import 'package:flutter_ui_radio/models/station_model.dart';
import 'package:flutter_ui_radio/networking/repository/station_repository.dart';
import 'package:flutter_ui_radio/pages/_widgets/primary_button.dart';
import 'package:flutter_ui_radio/pages/station_page/station_page.dart';
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
            actions: const [],
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
  List<Station> _stations = [];

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<StationsBloc, StationsState>(
        listener: (context, state) {
          if (state is SuccessStationsState) {
            (state.page == 0)
                ? _stations = state.stations
                : _stations.addAll(state.stations);
          }
        },
        builder: (_, state) {
          if (state is LoadingStationsState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SuccessStationsState) {
            if (_stations.isEmpty) {
              return const Center(child: Text('Empty...'));
            }
            return RefreshIndicator(
              color: CustomTheme.black,
              child: PerspectiveListView(
                itemExtent: MediaQuery.of(context).size.width,
                visualizedCount: 8,
                initialIndex: 7,
                padding: EdgeInsets.fromLTRB(
                  16.0,
                  AppBar().preferredSize.height,
                  16.0,
                  16.0,
                ),
                children: List.generate(
                  _stations.length,
                  (index) => StationCard(
                    station: _stations[index],
                    index: index,
                    total: state.meta.totalCount,
                  ),
                ),
                onChangeItem: (int index) {
                  log('onChangeItem: $index / ${_stations.length}');
                  if (index == _stations.length - 10 && state.hasMorePages) {
                    context.read<StationsBloc>().add(const NextStationsEvent());
                  }
                },
                onTapFrontItem: (int index) {
                  log('onTapFrontItem: $index');
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => StationPage(
                        station: _stations[index],
                      ),
                    ),
                  );
                },
              ),
              onRefresh: () async {
                _stations = [];
                context.read<StationsBloc>().add(const FirstStationsEvent());
              },
            );
          } else if (state is ErrorStationsState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const SizedBox(height: 16.0),
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
            child: Text('Empy'),
          );
        },
      );
}
