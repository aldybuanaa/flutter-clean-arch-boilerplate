import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/sample.dart';

part 'sample_model.g.dart';

/// Data model for [Sample] with JSON serialization via json_serializable.
///
/// Run `dart run build_runner build` to (re-)generate [sample_model.g.dart].
@JsonSerializable()
class SampleModel extends Sample {
  const SampleModel({
    required super.id,
    required super.title,
    required super.description,
  });

  /// Creates a [SampleModel] from a JSON map.
  factory SampleModel.fromJson(Map<String, dynamic> json) =>
      _$SampleModelFromJson(json);

  /// Converts this [SampleModel] to a JSON map.
  Map<String, dynamic> toJson() => _$SampleModelToJson(this);
}
