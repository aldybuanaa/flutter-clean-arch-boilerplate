import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/sample/presentation/pages/sample_page.dart';

/// App route names — use these constants instead of raw strings.
class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String sample = '/sample';
}

/// Centralized router configuration using GoRouter.
///
/// Register this in [MaterialApp.router] as the `routerConfig`.
class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const SamplePage(),
      ),
      GoRoute(
        path: '${AppRoutes.sample}/:id',
        name: 'sample-detail',
        builder: (context, state) {
          // final id = state.pathParameters['id'];
          return const SamplePage();
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.map_outlined, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text('Route not found: ${state.uri}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}
