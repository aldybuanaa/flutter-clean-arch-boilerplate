import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_clean_arch_boilerplate/core/error/failure.dart';
import 'package:flutter_clean_arch_boilerplate/features/sample/domain/entities/sample.dart';
import 'package:flutter_clean_arch_boilerplate/features/sample/domain/usecases/get_sample.dart';
import 'package:flutter_clean_arch_boilerplate/features/sample/presentation/bloc/sample_bloc.dart';

// ─── Mocks ───────────────────────────────────────────────────────────────────
class MockGetSample extends Mock implements GetSample {}

void main() {
  late SampleBloc bloc;
  late MockGetSample mockGetSample;

  setUpAll(() {
    registerFallbackValue(const GetSampleParams(id: 0));
  });

  setUp(() {
    mockGetSample = MockGetSample();
    bloc = SampleBloc(getSample: mockGetSample);
  });

  tearDown(() => bloc.close());

  const tId = 1;
  const tSample = Sample(
    id: tId,
    title: 'Test Title',
    description: 'Test Description',
  );

  group('SampleBloc', () {
    test('initial state is SampleInitial', () {
      expect(bloc.state, isA<SampleInitial>());
    });

    blocTest<SampleBloc, SampleState>(
      'emits [SampleLoading, SampleLoaded] when GetSampleEvent succeeds',
      build: () {
        when(
          () => mockGetSample(any()),
        ).thenAnswer((_) async => const Right(tSample));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetSampleEvent(id: tId)),
      expect: () => [
        isA<SampleLoading>(),
        isA<SampleLoaded>().having((s) => s.sample, 'sample', tSample),
      ],
    );

    blocTest<SampleBloc, SampleState>(
      'emits [SampleLoading, SampleError] when GetSampleEvent fails',
      build: () {
        when(() => mockGetSample(any())).thenAnswer(
          (_) async => const Left(ServerFailure(message: 'Server Error')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const GetSampleEvent(id: tId)),
      expect: () => [
        isA<SampleLoading>(),
        isA<SampleError>().having((s) => s.message, 'message', 'Server Error'),
      ],
    );
  });
}
