import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/sample.dart';
import '../../domain/repositories/sample_repository.dart';
import '../datasources/sample_local_data_source.dart';
import '../datasources/sample_remote_data_source.dart';

/// Implementation of [SampleRepository].
///
/// This class coordinates between remote and local data sources,
/// handles exceptions, and returns [Failure] or data accordingly.
class SampleRepositoryImpl implements SampleRepository {
  final SampleRemoteDataSource remoteDataSource;
  final SampleLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  SampleRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Sample>> getSample(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteSample = await remoteDataSource.getSample(id);
        await localDataSource.cacheSample(remoteSample);
        return Right(remoteSample);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localSample = await localDataSource.getLastSample();
        return Right(localSample);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }
}
