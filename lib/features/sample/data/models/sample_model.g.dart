// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SampleModel _$SampleModelFromJson(Map<String, dynamic> json) => SampleModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String,
);

Map<String, dynamic> _$SampleModelToJson(SampleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
    };
