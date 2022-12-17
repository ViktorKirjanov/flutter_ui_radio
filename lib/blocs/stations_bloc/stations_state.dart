part of 'stations_bloc.dart';

class StationsState extends Equatable {
  const StationsState({
    required this.page,
    required this.stations,
    required this.total,
    required this.hasMorePages,
    required this.isLoading,
    required this.error,
  });

  factory StationsState.pure() => const StationsState(
        page: 0,
        stations: [],
        total: 0,
        hasMorePages: true,
        isLoading: false,
        error: null,
      );

  final int page;
  final List<Station> stations;
  final int total;
  final bool hasMorePages;
  final bool isLoading;
  final String? error;

  StationsState copyWith({
    int? page,
    List<Station>? stations,
    int? total,
    bool? hasMorePages,
    bool? isLoading,
    String? error,
  }) =>
      StationsState(
        page: page ?? this.page,
        stations: stations ?? this.stations,
        total: total ?? this.total,
        hasMorePages: hasMorePages ?? this.hasMorePages,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
      );

  @override
  String toString() =>
      'page: $page length: ${stations.length} more: $hasMorePages, total: $total, isLoading: $isLoading, error: $error';

  @override
  List<Object?> get props => [
        page,
        stations,
        total,
        hasMorePages,
        isLoading,
        error,
      ];
}
