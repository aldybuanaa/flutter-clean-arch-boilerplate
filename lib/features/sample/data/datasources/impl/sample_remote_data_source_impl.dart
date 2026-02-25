import 'package:dio/dio.dart';

import '../../../../../core/error/exceptions.dart';
import '../../models/sample_model.dart';
import '../sample_remote_data_source.dart';

/// Implementation of [SampleRemoteDataSource] using [Dio].
///
/// The [Dio] instance is preconfigured with [baseUrl] in [injection_container.dart].
class SampleRemoteDataSourceImpl implements SampleRemoteDataSource {
  final Dio dio;

  SampleRemoteDataSourceImpl({required this.dio});

  @override
  Future<SampleModel> getSample(int id) async {
    try {
      final response = await dio.get('/samples/$id');

      if (response.statusCode == 200) {
        return SampleModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw const ServerException(message: 'Failed to fetch sample data');
      }
    } on DioException catch (e) {
      throw ServerException(
        message: e.message ?? 'An unexpected network error occurred',
      );
    }
  }
}
