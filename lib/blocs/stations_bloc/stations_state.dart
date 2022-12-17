part of 'stations_bloc.dart';

abstract class StationsState extends Equatable {
  const StationsState();

  @override
  List<Object> get props => [];
}

class InitialStationsState extends StationsState {}

class LoadingStationsState extends StationsState {}

class SuccessStationsState extends StationsState {
  const SuccessStationsState(
    this.page,
    this.stations,
    this.meta,
    this.hasMorePages,
  );

  final int page;
  final List<Station> stations;
  final Meta meta;
  final bool hasMorePages;

  @override
  List<Object> get props => [
        page,
        stations,
        meta,
        hasMorePages,
      ];

  @override
  String toString() =>
      'page: $page length: ${stations.length} hasMorePages: $hasMorePages';
}

class ErrorStationsState extends StationsState {
  const ErrorStationsState({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
