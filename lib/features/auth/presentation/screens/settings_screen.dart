import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_wallet/features/auth/presentation/providers/auth_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final authNotifier = ref.read(authControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Security',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ),
          ListTile(
            title: const Text('Onboarding Completed'),
            trailing: Icon(
              authState.hasCompletedOnboarding ? Icons.check_circle : Icons.cancel,
              color: authState.hasCompletedOnboarding ? Colors.green : Colors.red,
            ),
          ),
          ListTile(
            title: const Text('PIN Enabled'),
            trailing: Icon(
              authState.isPinEnabled ? Icons.check_circle : Icons.cancel,
              color: authState.isPinEnabled ? Colors.green : Colors.red,
            ),
          ),
          ListTile(
            title: const Text('Biometrics Available'),
            trailing: Icon(
              authState.canUseBiometrics ? Icons.check_circle : Icons.cancel,
              color: authState.canUseBiometrics ? Colors.green : Colors.red,
            ),
          ),
          if (authState.canUseBiometrics)
            SwitchListTile(
              title: const Text('Enable Biometrics'),
              value: authState.isBiometricEnabled,
              onChanged: (value) {
                if (value) {
                  authNotifier.enableBiometrics();
                } else {
                  authNotifier.disableBiometrics();
                }
              },
            ),
        ],
      ),
    );
  }
}
