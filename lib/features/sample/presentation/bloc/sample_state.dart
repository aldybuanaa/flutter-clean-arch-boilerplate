part of 'sample_bloc.dart';

/// Base class for all Sample BLoC states.
abstract class SampleState extends Equatable {
  const SampleState();

  @override
  List<Object> get props => [];
}

/// Initial state before any action is taken.
class SampleInitial extends SampleState {}

/// State while the sample data is being fetched.
class SampleLoading extends SampleState {}

/// State when the sample data has been successfully loaded.
class SampleLoaded extends SampleState {
  final Sample sample;

  const SampleLoaded({required this.sample});

  @override
  List<Object> get props => [sample];
}

/// State when an error occurred while fetching sample data.
class SampleError extends SampleState {
  final String message;

  const SampleError({required this.message});

  @override
  List<Object> get props => [message];
}
