import '../models/sample_model.dart';

/// Abstract data source contract for local caching related to Sample.
abstract class SampleLocalDataSource {
  /// Gets the last cached [SampleModel].
  ///
  /// Throws a [CacheException] if no cached data is present.
  Future<SampleModel> getLastSample();

  /// Caches the given [SampleModel] to persistent storage.
  Future<void> cacheSample(SampleModel sampleToCache);
}
