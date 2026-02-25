import 'package:shared_preferences/shared_preferences.dart';

/// Abstract interface for local key-value storage.
abstract class LocalStorage {
  Future<String?> getString(String key);
  Future<void> setString(String key, String value);

  Future<int?> getInt(String key);
  Future<void> setInt(String key, int value);

  Future<bool?> getBool(String key);
  Future<void> setBool(String key, bool value);

  Future<List<String>?> getStringList(String key);
  Future<void> setStringList(String key, List<String> value);

  Future<void> remove(String key);
  Future<void> clear();
}

/// Implementation of [LocalStorage] using [SharedPreferences].
class SharedPreferencesStorage implements LocalStorage {
  final SharedPreferences _prefs;

  SharedPreferencesStorage(this._prefs);

  @override
  Future<String?> getString(String key) async => _prefs.getString(key);

  @override
  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  @override
  Future<int?> getInt(String key) async => _prefs.getInt(key);

  @override
  Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  @override
  Future<bool?> getBool(String key) async => _prefs.getBool(key);

  @override
  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  @override
  Future<List<String>?> getStringList(String key) async =>
      _prefs.getStringList(key);

  @override
  Future<void> setStringList(String key, List<String> value) async {
    await _prefs.setStringList(key, value);
  }

  @override
  Future<void> remove(String key) async => _prefs.remove(key);

  @override
  Future<void> clear() async => _prefs.clear();
}

/// Storage keys used throughout the app.
class StorageKeys {
  StorageKeys._();

  static const String authToken = 'auth_token';
  static const String cachedSample = 'cached_sample';
  static const String userLocale = 'user_locale';
}
