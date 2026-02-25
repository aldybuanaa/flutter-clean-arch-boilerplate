import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'core/network/network_info.dart';
import 'core/utils/constants.dart';
import 'features/sample/data/datasources/sample_local_data_source.dart';
import 'features/sample/data/datasources/sample_remote_data_source.dart';
import 'features/sample/data/repositories/sample_repository_impl.dart';
import 'features/sample/domain/repositories/sample_repository.dart';
import 'features/sample/domain/usecases/get_sample.dart';
import 'features/sample/presentation/bloc/sample_bloc.dart';

/// Global service locator instance.
final sl = GetIt.instance;

/// Initializes all dependencies in the service locator.
///
/// Call this function in `main()` before `runApp()`.
Future<void> init() async {
  //--------------------------------------------------
  // Features - Sample
  //--------------------------------------------------

  // Bloc
  sl.registerFactory(() => SampleBloc(getSample: sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetSample(sl()));

  // Repository
  sl.registerLazySingleton<SampleRepository>(
    () => SampleRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<SampleRemoteDataSource>(
    () => SampleRemoteDataSourceImpl(dio: sl()),
  );

  sl.registerLazySingleton<SampleLocalDataSource>(
    () => SampleLocalDataSourceImpl(),
  );

  //--------------------------------------------------
  // Core
  //--------------------------------------------------

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //--------------------------------------------------
  // External
  //--------------------------------------------------

  sl.registerLazySingleton(
    () => Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(seconds: AppConstants.connectionTimeout),
        receiveTimeout: const Duration(seconds: AppConstants.receiveTimeout),
      ),
    ),
  );

  sl.registerLazySingleton(() => InternetConnection());
}
