import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_radio/blocs/stations_bloc/stations_bloc.dart';
import 'package:flutter_ui_radio/core/exceptions/exceptions.dart';
import 'package:flutter_ui_radio/core/exceptions/network_exceptions.dart';
import 'package:flutter_ui_radio/networking/repository/station_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../constants.dart';

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
    expect(buildBloc().state, equals(StationsState.pure()));
  });

  const firstState = StationsState(
    page: 1,
    stations: stations,
    total: 2,
    isLoading: false,
    hasMorePages: true,
    error: null,
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
        StationsState.pure().copyWith(isLoading: true),
        StationsState.pure().copyWith(
          isLoading: false,
          error: 'Request Cancelled',
        ),
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
        StationsState.pure().copyWith(isLoading: true),
        StationsState.pure().copyWith(
          page: 1,
          isLoading: false,
          stations: stations,
          total: 2,
          hasMorePages: true,
        ),
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
      seed: () => firstState,
      act: (StationsBloc bloc) async => bloc.add(const NextStationsEvent()),
      expect: () => [
        firstState.copyWith(isLoading: true),
        firstState.copyWith(
          isLoading: false,
          error: 'Request Cancelled',
        ),
      ],
      verify: (_) => verify(
        () => mockStationRepository.getStations(any(), any()),
      ).called(1),
    );

    blocTest<StationsBloc, StationsState>(
      'should emit [Success] when data is gotten successfully',
      setUp: setUpMockGetStationsSuccess,
      build: buildBloc,
      seed: () => firstState,
      act: (StationsBloc bloc) async => bloc.add(const NextStationsEvent()),
      expect: () => [
        firstState.copyWith(isLoading: true),
        firstState.copyWith(
          page: 2,
          isLoading: false,
          stations: [...stations, ...stations],
          hasMorePages: false,
        ),
      ],
      verify: (_) => verify(
        () => mockStationRepository.getStations(any(), any()),
      ).called(1),
    );

    blocTest<StationsBloc, StationsState>(
      'should emit [Error] when current state is not Success',
      setUp: setUpMockGetStationsSuccess,
      build: buildBloc,
      seed: StationsState.pure,
      act: (StationsBloc bloc) async => bloc.add(const NextStationsEvent()),
      expect: () => [
        StationsState.pure().copyWith(error: 'Ooops, something went wrong'),
      ],
      verify: (_) => verifyNever(
        () => mockStationRepository.getStations(any(), any()),
      ),
    );
  });
}
