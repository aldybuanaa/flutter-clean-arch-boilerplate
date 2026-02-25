import 'dart:convert';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/storage/local_storage.dart';
import '../../models/sample_model.dart';
import '../sample_local_data_source.dart';

/// Implementation of [SampleLocalDataSource] using [LocalStorage] (SharedPreferences).
class SampleLocalDataSourceImpl implements SampleLocalDataSource {
  final LocalStorage localStorage;

  SampleLocalDataSourceImpl({required this.localStorage});

  @override
  Future<SampleModel> getLastSample() async {
    final jsonString = await localStorage.getString(StorageKeys.cachedSample);

    if (jsonString != null) {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return SampleModel.fromJson(json);
    } else {
      throw const CacheException(message: 'No cached sample data found');
    }
  }

  @override
  Future<void> cacheSample(SampleModel sampleToCache) async {
    await localStorage.setString(
      StorageKeys.cachedSample,
      jsonEncode(sampleToCache.toJson()),
    );
  }
}
