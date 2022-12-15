import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_radio/blocs/stations_bloc/stations_bloc.dart';
import 'package:flutter_ui_radio/models/links_model.dart';
import 'package:flutter_ui_radio/models/station_model.dart';

void main() {
  group('SearchState', () {
    test('should supports InitialSearchState value comparison', () {
      expect(InitialStationsState(), InitialStationsState());
    });

    test('should supports LoadingSearchState value comparison', () {
      expect(LoadingStationsState(), LoadingStationsState());
    });

    test('should supports SuccessSearchState value comparison', () {
      expect(
        const SuccessStationsState(
          1,
          [
            Station(
              id: 'ps.106614797',
              href: 'https://api.napster.com/v2.2/stations/ps.106614797',
              name: 'EDM Central',
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
          false,
        ),
        const SuccessStationsState(
          1,
          [
            Station(
              id: 'ps.106614797',
              href: 'https://api.napster.com/v2.2/stations/ps.106614797',
              name: 'EDM Central',
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
          false,
        ),
      );
    });

    test('should supports ErrorSearchState value comparison', () {
      expect(
        const ErrorStationsState(message: 'error'),
        const ErrorStationsState(message: 'error'),
      );
    });
  });
}
