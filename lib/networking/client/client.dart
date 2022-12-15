import 'package:dio/dio.dart';
import 'package:flutter_ui_radio/config/consts.dart';
import 'package:flutter_ui_radio/models/stations_response_model.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

// *** CLIENT *** //
@RestApi(baseUrl: Api.baseUrl)
abstract class APIClient {
  factory APIClient(Dio dio, {String baseUrl}) = _APIClient;

  @GET(Api.stationsPath)
  Future<StationsResponse> getStations(
    @Query('apikey') String apiKey,
    @Query('limit') int limit,
    @Query('offset') int offset,
  );
}
