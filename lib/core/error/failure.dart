import 'package:equatable/equatable.dart';

/// Base class for all failures in the application.
/// Each failure type represents a specific category of error.
abstract class Failure extends Equatable {
  final String message;

  const Failure({this.message = ''});

  @override
  List<Object> get props => [message];
}

/// Failure originating from the server/API.
class ServerFailure extends Failure {
  const ServerFailure({super.message});
}

/// Failure originating from the local cache.
class CacheFailure extends Failure {
  const CacheFailure({super.message});
}
