import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_radio/blocs/stations_bloc/stations_bloc.dart';
import 'package:flutter_ui_radio/config/custom_theme.dart';
import 'package:flutter_ui_radio/models/station_model.dart';
import 'package:flutter_ui_radio/networking/repository/station_repository.dart';
import 'package:flutter_ui_radio/pages/station_page/station_page.dart';

class StationsPage extends StatelessWidget {
  const StationsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Stations'),
        ),
        body: BlocProvider(
          create: (context) => StationsBloc(
            stationRepository: context.read<StationRepository>(),
          )..add(const FirstStationsEvent()),
          child: const _StationsView(),
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
              color: CustomTheme.blue,
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 60.0),
                itemCount: _stations.length + 1,
                itemBuilder: (_, index) {
                  if (index == _stations.length - 1) {
                    if (state.hasMorePages) {
                      context
                          .read<StationsBloc>()
                          .add(const NextStationsEvent());
                    }
                  }

                  if (index == _stations.length) {
                    return state.hasMorePages
                        ? const Text('Loading...')
                        : const Text('end of list');
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          color: Colors.grey.shade800,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(index.toString()),
                              Text(_stations[index].name),
                            ],
                          ),
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (context) => StationPage(
                              station: _stations[index],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
              onRefresh: () async {
                _stations = [];
                context.read<StationsBloc>().add(const FirstStationsEvent());
              },
            );
          } else if (state is ErrorStationsState) {
            return Center(child: Text(state.message));
          }

          return const Center(
            child: Text('Empy'),
          );
        },
      );
}
