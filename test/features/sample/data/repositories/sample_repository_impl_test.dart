import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_clean_arch_boilerplate/core/error/exceptions.dart';
import 'package:flutter_clean_arch_boilerplate/core/error/failure.dart';
import 'package:flutter_clean_arch_boilerplate/core/network/network_info.dart';
import 'package:flutter_clean_arch_boilerplate/features/sample/data/datasources/sample_local_data_source.dart';
import 'package:flutter_clean_arch_boilerplate/features/sample/data/datasources/sample_remote_data_source.dart';
import 'package:flutter_clean_arch_boilerplate/features/sample/data/models/sample_model.dart';
import 'package:flutter_clean_arch_boilerplate/features/sample/data/repositories/sample_repository_impl.dart';

// ─── Mocks ───────────────────────────────────────────────────────────────────
class MockRemoteDataSource extends Mock implements SampleRemoteDataSource {}

class MockLocalDataSource extends Mock implements SampleLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late SampleRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUpAll(() {
    // Register fallback values required by mocktail for non-primitive types
    registerFallbackValue(const SampleModel(id: 0, title: '', description: ''));
  });

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = SampleRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  const tId = 1;
  const tSampleModel = SampleModel(
    id: tId,
    title: 'Test Title',
    description: 'Test Description',
  );

  group('SampleRepositoryImpl', () {
    group('when device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return remote data and cache it on success', () async {
        // Arrange
        when(
          () => mockRemoteDataSource.getSample(any()),
        ).thenAnswer((_) async => tSampleModel);
        when(
          () => mockLocalDataSource.cacheSample(any()),
        ).thenAnswer((_) async {});

        // Act
        final result = await repository.getSample(tId);

        // Assert
        expect(result, equals(const Right(tSampleModel)));
        verify(() => mockRemoteDataSource.getSample(tId)).called(1);
        verify(() => mockLocalDataSource.cacheSample(tSampleModel)).called(1);
      });

      test(
        'should return ServerFailure when remote data source throws',
        () async {
          // Arrange
          when(
            () => mockRemoteDataSource.getSample(any()),
          ).thenThrow(const ServerException(message: 'Server error'));

          // Act
          final result = await repository.getSample(tId);

          // Assert
          expect(result, const Left(ServerFailure(message: 'Server error')));
          verifyNever(() => mockLocalDataSource.cacheSample(any()));
        },
      );
    });

    group('when device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return cached data when available', () async {
        // Arrange
        when(
          () => mockLocalDataSource.getLastSample(),
        ).thenAnswer((_) async => tSampleModel);

        // Act
        final result = await repository.getSample(tId);

        // Assert
        expect(result, const Right(tSampleModel));
        verifyNever(() => mockRemoteDataSource.getSample(any()));
      });

      test('should return CacheFailure when no cached data', () async {
        // Arrange
        when(
          () => mockLocalDataSource.getLastSample(),
        ).thenThrow(const CacheException(message: 'No cache'));

        // Act
        final result = await repository.getSample(tId);

        // Assert
        expect(result, const Left(CacheFailure(message: 'No cache')));
      });
    });
  });
}
