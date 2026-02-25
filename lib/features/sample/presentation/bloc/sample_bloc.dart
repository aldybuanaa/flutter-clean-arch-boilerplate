import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/sample.dart';
import '../../domain/usecases/get_sample.dart';

part 'sample_event.dart';
part 'sample_state.dart';

/// BLoC for the Sample feature.
///
/// Receives [SampleEvent]s and maps them to [SampleState]s.
/// Business logic is delegated to the injected [GetSample] use case.
class SampleBloc extends Bloc<SampleEvent, SampleState> {
  final GetSample getSample;

  SampleBloc({required this.getSample}) : super(SampleInitial()) {
    on<GetSampleEvent>(_onGetSample);
  }

  Future<void> _onGetSample(
    GetSampleEvent event,
    Emitter<SampleState> emit,
  ) async {
    emit(SampleLoading());

    final result = await getSample(GetSampleParams(id: event.id));

    result.fold(
      (failure) => emit(SampleError(message: failure.message)),
      (sample) => emit(SampleLoaded(sample: sample)),
    );
  }
}
