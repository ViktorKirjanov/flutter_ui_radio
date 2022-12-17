import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_radio/config/consts.dart';
import 'package:flutter_ui_radio/core/exceptions/exceptions.dart';
import 'package:flutter_ui_radio/core/exceptions/network_exceptions.dart';
import 'package:flutter_ui_radio/models/links_model.dart';
import 'package:flutter_ui_radio/models/station_model.dart';
import 'package:flutter_ui_radio/models/stations_response_model.dart';
import 'package:flutter_ui_radio/networking/client/client.dart';
import 'package:flutter_ui_radio/networking/repository/station_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements APIClient {}

void main() {
  registerFallbackValue(Uri());
  late RemoteStationRepository repository;
  late MockClient client;

  setUp(() {
    client = MockClient();
    repository = RemoteStationRepository(client: client);
  });

  final error = DioError(
    response: Response(
      data: 'Something went wrong',
      statusCode: 404,
      requestOptions: RequestOptions(path: ''),
    ),
    requestOptions: RequestOptions(path: ''),
    type: DioErrorType.cancel,
  );

  final networkException = NetworkExceptions.getDioException(error);

  group('getStations', () {
    const stationsResponse = StationsResponse(
      stations: [
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
        ),
      ],
      meta: Meta(
        totalCount: 1,
        returnedCount: 1,
      ),
    );

    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(() => client.getStations(any(), any(), any()))
            .thenAnswer((_) async => stationsResponse);
        // act
        final result = await repository.getStations(10, 0);
        // assert
        verify(() => client.getStations(Api.apikey, 10, 0));
        expect(
          result,
          equals(
            const Right<NetworkFailure, StationsResponse>(
              stationsResponse,
            ),
          ),
        );
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(() => client.getStations(any(), any(), any())).thenThrow(error);
        // act
        final result = await repository.getStations(10, 0);
        // assert
        verify(() => client.getStations(Api.apikey, 10, 0));
        expect(
          result,
          equals(
            Left<NetworkFailure, StationsResponse>(
              NetworkFailure(networkException),
            ),
          ),
        );
      },
    );
  });
}
