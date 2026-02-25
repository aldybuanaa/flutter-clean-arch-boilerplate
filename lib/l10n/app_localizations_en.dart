// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Flutter Clean Arch';

  @override
  String get homeTitle => 'Home';

  @override
  String get fetchSample => 'Fetch Sample';

  @override
  String get loadingMessage => 'Loading...';

  @override
  String get errorRetry => 'Retry';

  @override
  String get errorGeneric => 'Something went wrong. Please try again.';

  @override
  String sampleId(int id) {
    return 'ID: $id';
  }
}
