import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_wallet/features/auth/presentation/providers/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'AI Insights',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.purple),
            ),
          ),
          ListTile(
            title: const Text('Gemini API Key'),
            subtitle: const Text('Enter your API key to generate financial insights.'),
            trailing: const Icon(Icons.edit),
            onTap: () => _showApiKeyDialog(context),
          ),
        ],
      ),
    );
  }

  Future<void> _showApiKeyDialog(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final currentKey = prefs.getString('gemini_api_key') ?? '';
    final controller = TextEditingController(text: currentKey);

    if (!context.mounted) return;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Gemini API Key'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Enter your API key',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await prefs.setString('gemini_api_key', controller.text);
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('API Key saved successfully.')),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
