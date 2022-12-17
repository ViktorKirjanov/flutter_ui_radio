import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_radio/blocs/bloc_observer.dart';
import 'package:flutter_ui_radio/config/custom_theme.dart';
import 'package:flutter_ui_radio/networking/client/client.dart';
import 'package:flutter_ui_radio/networking/repository/station_repository.dart';
import 'package:flutter_ui_radio/pages/stations_page/stations_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();

  runApp(
    MyApp(
      stationRepository: RemoteStationRepository(client: APIClient(Dio())),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.stationRepository});

  final StationRepository stationRepository;

  @override
  Widget build(BuildContext context) =>
      RepositoryProvider<StationRepository>.value(
        value: stationRepository,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          themeMode: ThemeMode.dark,
          theme: CustomTheme.darkTheme,
          home: const StationsPage(),
        ),
      );
}
