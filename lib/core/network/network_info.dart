import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// Abstract class to check network connectivity.
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

/// Implementation of [NetworkInfo] using [InternetConnection].
class NetworkInfoImpl implements NetworkInfo {
  final InternetConnection connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasInternetAccess;
}
