import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_wallet/features/insights/presentation/providers/insights_provider.dart';

class InsightsScreen extends ConsumerStatefulWidget {
  const InsightsScreen({super.key});

  @override
  ConsumerState<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends ConsumerState<InsightsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(insightsNotifierProvider.notifier).generateInsight();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(insightsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gemini Insights'),
      ),
      body: _buildBody(state),
    );
  }

  Widget _buildBody(InsightsState state) {
    if (state.apiKeyMissing) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.vpn_key_off, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              const Text(
                'Gemini API Key Required',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'To view AI-powered financial insights, please add your Gemini API Key in the Settings.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.push('/settings'),
                child: const Text('Go to Settings'),
              ),
            ],
          ),
        ),
      );
    }

    if (state.isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Generating AI Insights...'),
          ],
        ),
      );
    }

    if (state.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text('Failed to generate insights', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              Text(state.error!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => ref.read(insightsNotifierProvider.notifier).generateInsight(),
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      );
    }

    if (state.insightText != null) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.auto_awesome, color: Colors.purple.shade400),
                const SizedBox(width: 8),
                const Text(
                  'Your Financial Insights',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  state.insightText!,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: OutlinedButton.icon(
                onPressed: () => ref.read(insightsNotifierProvider.notifier).generateInsight(),
                icon: const Icon(Icons.refresh),
                label: const Text('Regenerate'),
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
