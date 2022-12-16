import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_radio/blocs/stations_bloc/stations_bloc.dart';
import 'package:flutter_ui_radio/core/exceptions/exceptions.dart';
import 'package:flutter_ui_radio/core/exceptions/network_exceptions.dart';
import 'package:flutter_ui_radio/models/links_model.dart';
// import 'package:flutter_ui_radio/models/meta_model.dart';
import 'package:flutter_ui_radio/models/station_model.dart';
import 'package:flutter_ui_radio/models/stations_response_model.dart';
import 'package:flutter_ui_radio/networking/repository/station_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockStationRepository extends Mock implements StationRepository {}

void main() {
  late MockStationRepository mockStationRepository;

  setUp(() {
    mockStationRepository = MockStationRepository();
  });

  StationsBloc buildBloc() =>
      StationsBloc(stationRepository: mockStationRepository);

  test('works properly', () {
    expect(buildBloc, returnsNormally);
  });

  test('initial state should be InitialStationsState', () {
    expect(buildBloc().state, equals(InitialStationsState()));
  });

  const stations = [
    Station(
      id: 'ps.106614797',
      href: 'https://api.napster.com/v2.2/stations/ps.106614797',
      name: 'EDM Central',
      description:
          'Electro-house, trance, dubstep and more\nThe biggest tunes from the biggest festivals\nTracks for rocking the big tent\nClub peaktime comes to your living room\nEDM nonstop',
      summary: 'The hottest in EDM and crossover dance music.',
      artists: 'Avicii, Swedish House Mafia, Deadmau5',
      links: Links(
        mediumImage: Link(
          href:
              'http://static.rhap.com/img/150x100/7/8/2/6/4126287_150x100.jpg',
        ),
        largeImage: Link(
          href:
              'http://static.rhap.com/img/356x237/7/8/2/6/4126287_356x237.jpg',
        ),
      ),
    )
  ];

  const stationsResponse = StationsResponse(
    stations: stations,
    // meta: Meta(
    //   totalCount: 1,
    //   returnedCount: 1,
    // ),
  );

  void setUpMockGetStationsExeption() =>
      when(() => mockStationRepository.getStations(any(), any())).thenAnswer(
        (_) async =>
            Left(NetworkFailure(const NetworkExceptions.requestCancelled())),
      );

  void setUpMockGetStationsSuccess() =>
      when(() => mockStationRepository.getStations(any(), any()))
          .thenAnswer((_) async => const Right(stationsResponse));

  group('test FirstStationsEvent', () {
    blocTest<StationsBloc, StationsState>(
      'should emit [Loading, Error] when api thow an error',
      setUp: setUpMockGetStationsExeption,
      build: buildBloc,
      act: (StationsBloc bloc) async => bloc.add(const FirstStationsEvent()),
      expect: () => [
        LoadingStationsState(),
        const ErrorStationsState(message: 'Request Cancelled'),
      ],
      verify: (_) => verify(
        () => mockStationRepository.getStations(any(), any()),
      ).called(1),
    );

    blocTest<StationsBloc, StationsState>(
      'should emit [Loading, Success] when data is gotten successfully',
      setUp: setUpMockGetStationsSuccess,
      build: buildBloc,
      act: (StationsBloc bloc) async => bloc.add(const FirstStationsEvent()),
      expect: () => [
        LoadingStationsState(),
        const SuccessStationsState(1, stations, false),
      ],
      verify: (_) => verify(
        () => mockStationRepository.getStations(any(), any()),
      ).called(1),
    );
  });

  group('NextStationsEvent', () {
    blocTest<StationsBloc, StationsState>(
      'should emit [Error] when api thow an error',
      setUp: setUpMockGetStationsExeption,
      build: buildBloc,
      seed: () => const SuccessStationsState(1, stations, false),
      act: (StationsBloc bloc) async => bloc.add(const NextStationsEvent()),
      expect: () => [
        const ErrorStationsState(message: 'Request Cancelled'),
      ],
      verify: (_) => verify(
        () => mockStationRepository.getStations(any(), any()),
      ).called(1),
    );

    blocTest<StationsBloc, StationsState>(
      'should emit [Success] when data is gotten successfully',
      setUp: setUpMockGetStationsSuccess,
      build: buildBloc,
      seed: () => const SuccessStationsState(1, stations, true),
      act: (StationsBloc bloc) async => bloc.add(const NextStationsEvent()),
      expect: () => [const SuccessStationsState(2, stations, false)],
      verify: (_) => verify(
        () => mockStationRepository.getStations(any(), any()),
      ).called(1),
    );

    blocTest<StationsBloc, StationsState>(
      'should emit [Error] when current state is not Success',
      setUp: setUpMockGetStationsSuccess,
      build: buildBloc,
      seed: InitialStationsState.new,
      act: (StationsBloc bloc) async => bloc.add(const NextStationsEvent()),
      expect: () =>
          [const ErrorStationsState(message: 'Ooops, something went wrong')],
      verify: (_) => verifyNever(
        () => mockStationRepository.getStations(any(), any()),
      ),
    );
  });
}
