import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/sample.dart';

/// Repository contract for the Sample feature.
///
/// This abstract class defines the interface that the Data layer must implement.
/// The Domain layer depends only on this abstraction, not on the implementation.
abstract class SampleRepository {
  /// Fetches a [Sample] by its [id].
  ///
  /// Returns [Right(Sample)] on success or [Left(Failure)] on error.
  Future<Either<Failure, Sample>> getSample(int id);
}
