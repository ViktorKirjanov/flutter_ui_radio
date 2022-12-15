import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_ui_radio/config/consts.dart';
import 'package:flutter_ui_radio/core/exceptions/exceptions.dart';
import 'package:flutter_ui_radio/core/exceptions/network_exceptions.dart';
import 'package:flutter_ui_radio/models/stations_response_model.dart';
import 'package:flutter_ui_radio/networking/client/client.dart';

abstract class StationRepository {
  Future<Either<Failure, StationsResponse>> getStations(
    int limit,
    int offset,
  );
}

class RemoteStationRepository implements StationRepository {
  RemoteStationRepository({required APIClient client}) : _client = client;

  final APIClient _client;

  @override
  Future<Either<Failure, StationsResponse>> getStations(
    int page,
    int offset,
  ) async {
    try {
      final stationsResponse = await _client
          .getStations(Api.apikey, page, offset)
          .then((msr) => msr);
      return Right(stationsResponse);
    } on DioError catch (e) {
      final exeption = NetworkExceptions.getDioException(e);
      return Left(NetworkFailure(exeption));
    }
  }
}
