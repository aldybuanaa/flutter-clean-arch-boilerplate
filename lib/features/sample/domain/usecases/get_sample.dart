import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/sample.dart';
import '../repositories/sample_repository.dart';

/// Use case for fetching a single [Sample] by its ID.
///
/// Implements the [UseCase] interface from the core layer.
class GetSample implements UseCase<Sample, GetSampleParams> {
  final SampleRepository repository;

  GetSample(this.repository);

  @override
  Future<Either<Failure, Sample>> call(GetSampleParams params) {
    return repository.getSample(params.id);
  }
}

/// Parameters required by [GetSample] use case.
class GetSampleParams extends Equatable {
  final int id;

  const GetSampleParams({required this.id});

  @override
  List<Object> get props => [id];
}
