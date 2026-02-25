import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failure.dart';

/// Generic UseCase interface that all use cases must implement.
///
/// [T] is the return type on success.
/// [Params] is the parameter type required for execution.
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// Used when a use case does not require any parameters.
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
