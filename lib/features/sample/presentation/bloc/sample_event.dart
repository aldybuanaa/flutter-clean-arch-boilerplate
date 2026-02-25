part of 'sample_bloc.dart';

/// Base class for all Sample BLoC events.
abstract class SampleEvent extends Equatable {
  const SampleEvent();

  @override
  List<Object> get props => [];
}

/// Event to trigger fetching a [Sample] by its ID.
class GetSampleEvent extends SampleEvent {
  final int id;

  const GetSampleEvent({required this.id});

  @override
  List<Object> get props => [id];
}
