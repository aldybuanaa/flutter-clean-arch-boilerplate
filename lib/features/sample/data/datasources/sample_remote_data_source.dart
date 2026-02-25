import '../models/sample_model.dart';

/// Abstract data source contract for remote API calls related to Sample.
abstract class SampleRemoteDataSource {
  /// Calls the API endpoint to get a [SampleModel] by [id].
  ///
  /// Throws a [ServerException] on failure.
  Future<SampleModel> getSample(int id);
}
