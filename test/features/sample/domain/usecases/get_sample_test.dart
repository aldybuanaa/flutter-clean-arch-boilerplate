import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_clean_arch_boilerplate/core/error/failure.dart';
import 'package:flutter_clean_arch_boilerplate/features/sample/domain/entities/sample.dart';
import 'package:flutter_clean_arch_boilerplate/features/sample/domain/repositories/sample_repository.dart';
import 'package:flutter_clean_arch_boilerplate/features/sample/domain/usecases/get_sample.dart';

// ─── Mocks ───────────────────────────────────────────────────────────────────
class MockSampleRepository extends Mock implements SampleRepository {}

void main() {
  late GetSample useCase;
  late MockSampleRepository mockRepository;

  setUp(() {
    mockRepository = MockSampleRepository();
    useCase = GetSample(mockRepository);
  });

  const tId = 1;
  const tSample = Sample(
    id: tId,
    title: 'Test Title',
    description: 'Test Description',
  );

  group('GetSample UseCase', () {
    test('should get a sample from the repository', () async {
      // Arrange
      when(
        () => mockRepository.getSample(any()),
      ).thenAnswer((_) async => const Right(tSample));

      // Act
      final result = await useCase(const GetSampleParams(id: tId));

      // Assert
      expect(result, const Right(tSample));
      verify(() => mockRepository.getSample(tId)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return ServerFailure when repository fails', () async {
      // Arrange
      const failure = ServerFailure(message: 'Server Error');
      when(
        () => mockRepository.getSample(any()),
      ).thenAnswer((_) async => const Left(failure));

      // Act
      final result = await useCase(const GetSampleParams(id: tId));

      // Assert
      expect(result, const Left(failure));
      verify(() => mockRepository.getSample(tId)).called(1);
    });
  });
}
