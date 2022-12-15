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
        super(InitialStationsState()) {
    on<FirstStationsEvent>(_onFirstStationsEvent);
    on<NextStationsEvent>(_onGetNextStationsEvent);
  }

  final StationRepository _stationRepository;

  Future<void> _onFirstStationsEvent(
    FirstStationsEvent event,
    Emitter<StationsState> emit,
  ) async {
    emit(LoadingStationsState());
    await _emitStation(emit, 0, Pagination.limit, 0);
  }

  Future<void> _onGetNextStationsEvent(
    NextStationsEvent _,
    Emitter<StationsState> emit,
  ) async {
    if (state is SuccessStationsState) {
      final currentState = state as SuccessStationsState;
      final currentPage = currentState.page + 1;
      final offset = currentPage * Pagination.limit;
      await _emitStation(emit, currentPage, Pagination.limit, offset);
    } else {
      emit(const ErrorStationsState(message: 'Ooops, something went wrong'));
    }
  }

  Future<void> _emitStation(
    Emitter<StationsState> emit,
    int page,
    int limit,
    int offset,
  ) async {
    final failureOrStations =
        await _stationRepository.getStations(limit, offset);
    failureOrStations.fold(
      (failure) => emit(
        ErrorStationsState(message: _mapFailureToMessage(failure)),
      ),
      (searchResponse) => emit(
        SuccessStationsState(
          page,
          searchResponse.stations,
          searchResponse.stations.length == Pagination.limit,
        ),
      ),
    );
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
