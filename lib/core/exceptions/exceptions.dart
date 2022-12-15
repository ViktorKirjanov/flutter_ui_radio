import 'package:equatable/equatable.dart';
import 'package:flutter_ui_radio/core/exceptions/network_exceptions.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class NetworkFailure extends Failure {
  NetworkFailure(this.exception);

  final NetworkExceptions exception;

  @override
  List<Object?> get props => [exception];

  @override
  bool? get stringify => true;
}
