// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Flutter Clean Arch';

  @override
  String get homeTitle => 'Beranda';

  @override
  String get fetchSample => 'Ambil Data';

  @override
  String get loadingMessage => 'Memuat...';

  @override
  String get errorRetry => 'Coba Lagi';

  @override
  String get errorGeneric => 'Terjadi kesalahan. Silakan coba lagi.';

  @override
  String sampleId(int id) {
    return 'ID: $id';
  }
}
