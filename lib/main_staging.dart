import 'package:flutter/material.dart';

import 'core/config/env_config.dart';
import 'core/utils/app_logger.dart';
import 'core/utils/app_theme.dart';
import 'core/router/app_router.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  AppLogger.i('🚀 Running in ${EnvConfig.env.toUpperCase()} mode');
  AppLogger.i('📡 API: ${EnvConfig.baseUrl}');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: EnvConfig.appName,
      debugShowCheckedModeBanner: true, // show banner in staging
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}
