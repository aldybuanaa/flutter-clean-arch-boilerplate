import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/constants.dart';
import '../models/sample_model.dart';

/// Abstract data source for remote API calls related to Sample.
abstract class SampleRemoteDataSource {
  /// Calls the API endpoint to get a [SampleModel] by [id].
  ///
  /// Throws a [ServerException] on failure.
  Future<SampleModel> getSample(int id);
}

/// Implementation of [SampleRemoteDataSource] using [Dio].
class SampleRemoteDataSourceImpl implements SampleRemoteDataSource {
  final Dio dio;

  SampleRemoteDataSourceImpl({required this.dio});

  @override
  Future<SampleModel> getSample(int id) async {
    try {
      final response = await dio.get('${AppConstants.baseUrl}/samples/$id');

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
