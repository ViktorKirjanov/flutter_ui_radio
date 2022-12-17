import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_radio/config/consts.dart';
import 'package:flutter_ui_radio/core/exceptions/exceptions.dart';
import 'package:flutter_ui_radio/core/exceptions/network_exceptions.dart';
import 'package:flutter_ui_radio/models/station_model.dart';
import 'package:flutter_ui_radio/networking/repository/station_repository.dart';

part 'stations_event.dart';
part 'stations_state.dart';

class StationsBloc extends Bloc<StationsEvent, StationsState> {
  StationsBloc({required StationRepository stationRepository})
      : _stationRepository = stationRepository,
        super(StationsState.pure()) {
    on<FirstStationsEvent>(_onFirstStationsEvent);
    on<NextStationsEvent>(_onGetNextStationsEvent);
  }

  final StationRepository _stationRepository;

  Future<void> _onFirstStationsEvent(
    FirstStationsEvent event,
    Emitter<StationsState> emit,
  ) async {
    await _emitStation(emit, 0, StationList.limit, 0);
  }

  Future<void> _onGetNextStationsEvent(
    NextStationsEvent _,
    Emitter<StationsState> emit,
  ) async {
    if (state.stations.isNotEmpty) {
      final currentPage = state.page + 1;
      final offset = currentPage * StationList.limit;
      await _emitStation(emit, currentPage, StationList.limit, offset);
    } else {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Ooops, something went wrong',
        ),
      );
    }
  }

  Future<void> _emitStation(
    Emitter<StationsState> emit,
    int page,
    int limit,
    int offset,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));
    final failureOrStations =
        await _stationRepository.getStations(limit, offset);
    failureOrStations.fold(
        (failure) => emit(
              state.copyWith(
                isLoading: false,
                error: _mapFailureToMessage(failure),
              ),
            ), (stationsResponse) {
      final stations = [...state.stations, ...stationsResponse.stations];

      emit(
        state.copyWith(
          page: state.page + 1,
          stations: stations,
          total: stationsResponse.meta.totalCount,
          hasMorePages: stations.length != stationsResponse.meta.totalCount,
          isLoading: false,
          error: null,
        ),
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
        final networkException = (failure as NetworkFailure).exception;
        final message = NetworkExceptions.getErrorMessage(networkException);
        return message;
      default:
        return 'Unexpected error';
    }
  }
}
