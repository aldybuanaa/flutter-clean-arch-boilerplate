import '../../../../core/error/exceptions.dart';
import '../models/sample_model.dart';

/// Abstract data source for local caching related to Sample.
abstract class SampleLocalDataSource {
  /// Gets the cached [SampleModel].
  ///
  /// Throws a [CacheException] if no cached data is present.
  Future<SampleModel> getLastSample();

  /// Caches the given [SampleModel].
  Future<void> cacheSample(SampleModel sampleToCache);
}

/// Implementation of [SampleLocalDataSource] using in-memory storage.
///
/// In a production app, replace this with SharedPreferences, Hive, or
/// a local database like SQLite/Drift.
class SampleLocalDataSourceImpl implements SampleLocalDataSource {
  SampleModel? _cachedSample;

  SampleLocalDataSourceImpl();

  @override
  Future<SampleModel> getLastSample() async {
    if (_cachedSample != null) {
      return _cachedSample!;
    } else {
      throw const CacheException(message: 'No cached sample data found');
    }
  }

  @override
  Future<void> cacheSample(SampleModel sampleToCache) async {
    _cachedSample = sampleToCache;
  }
}
