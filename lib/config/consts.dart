class Api {
  static const apikey = 'YTkxZTRhNzAtODdlNy00ZjMzLTg0MWItOTc0NmZmNjU4Yzk4';
  static const baseUrl = 'http://api.napster.com/';

  static const stationsPath = 'v2.2/stations';
}

class StationList {
  static const visualizedCount = 8;
  static const initialIndex = 8;
  static const limit = 25;
  static const timeout = Duration(milliseconds: 500);
}

class Animations {
  static const audioWaves = 3;
}
