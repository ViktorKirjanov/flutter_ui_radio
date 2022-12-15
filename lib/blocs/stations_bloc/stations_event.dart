part of 'stations_bloc.dart';

abstract class StationsEvent extends Equatable {
  const StationsEvent();

  @override
  List<Object> get props => [];
}

class FirstStationsEvent extends StationsEvent {
  const FirstStationsEvent();
}

class NextStationsEvent extends StationsEvent {
  const NextStationsEvent();
}
