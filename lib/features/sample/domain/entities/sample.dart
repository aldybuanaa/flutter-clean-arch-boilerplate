import 'package:equatable/equatable.dart';

/// Core business object representing a Sample entity.
///
/// This entity is framework-agnostic and belongs to the Domain layer.
class Sample extends Equatable {
  final int id;
  final String title;
  final String description;

  const Sample({
    required this.id,
    required this.title,
    required this.description,
  });

  @override
  List<Object> get props => [id, title, description];
}
