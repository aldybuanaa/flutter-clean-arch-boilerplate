import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/sample_bloc.dart';

/// Main page for the Sample feature.
///
/// Uses [BlocProvider] to inject [SampleBloc] from GetIt
/// and [BlocBuilder] to reactively build the UI based on state changes.
class SamplePage extends StatelessWidget {
  const SamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SampleBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Sample Feature')),
        body: BlocBuilder<SampleBloc, SampleState>(
          builder: (context, state) {
            if (state is SampleInitial) {
              return _buildInitialView(context);
            } else if (state is SampleLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SampleLoaded) {
              return _buildLoadedView(state);
            } else if (state is SampleError) {
              return _buildErrorView(state.message, context);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildInitialView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.touch_app, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'Press the button to fetch sample data',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              context.read<SampleBloc>().add(const GetSampleEvent(id: 1));
            },
            icon: const Icon(Icons.download),
            label: const Text('Fetch Sample'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadedView(SampleLoaded state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.sample.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'ID: ${state.sample.id}',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const Divider(height: 24),
                Text(
                  state.sample.description,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorView(String message, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(fontSize: 16, color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              context.read<SampleBloc>().add(const GetSampleEvent(id: 1));
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
