import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_radio/config/consts.dart';
import 'package:flutter_ui_radio/core/exceptions/exceptions.dart';
import 'package:flutter_ui_radio/core/exceptions/network_exceptions.dart';
import 'package:flutter_ui_radio/models/stations_response_model.dart';
import 'package:flutter_ui_radio/networking/client/client.dart';
import 'package:flutter_ui_radio/networking/repository/station_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../constants.dart';

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
