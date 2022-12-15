import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_radio/blocs/stations_bloc/stations_bloc.dart';

void main() {
  group('test SearchEvent', () {
    group('test FirstStationsEvent', () {
      test('should supports value equality', () {
        expect(
          const FirstStationsEvent(),
          equals(const FirstStationsEvent()),
        );
      });

      test('props are correct', () {
        expect(const FirstStationsEvent().props, equals(<Object>[]));
      });
    });

    group('test NextSearchEvent', () {
      test('should supports value equality', () {
        expect(
          const NextStationsEvent(),
          equals(const NextStationsEvent()),
        );
      });

      test('props are correct', () {
        expect(const NextStationsEvent().props, equals(<Object>[]));
      });
    });
  });
}
