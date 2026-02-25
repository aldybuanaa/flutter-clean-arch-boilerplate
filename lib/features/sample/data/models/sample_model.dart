import '../../domain/entities/sample.dart';

/// Data model for [Sample] that handles JSON serialization.
///
/// Extends the [Sample] entity to add data-layer concerns
/// (fromJson / toJson) without polluting the Domain layer.
class SampleModel extends Sample {
  const SampleModel({
    required super.id,
    required super.title,
    required super.description,
  });

  /// Creates a [SampleModel] from a JSON map.
  factory SampleModel.fromJson(Map<String, dynamic> json) {
    return SampleModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }

  /// Converts this [SampleModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'description': description};
  }
}
