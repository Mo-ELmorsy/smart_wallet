import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_wallet/features/auth/presentation/providers/auth_provider.dart';

class PinUnlockScreen extends ConsumerStatefulWidget {
  const PinUnlockScreen({super.key});

  @override
  ConsumerState<PinUnlockScreen> createState() => _PinUnlockScreenState();
}

class _PinUnlockScreenState extends ConsumerState<PinUnlockScreen> {
  String _pin = '';
  String? _error;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkBiometrics();
    });
  }

  Future<void> _checkBiometrics() async {
    final authState = ref.read(authControllerProvider);
    if (authState.isBiometricEnabled && authState.canUseBiometrics) {
      await _authenticateBiometrics();
    }
  }

  Future<void> _authenticateBiometrics() async {
    final success = await ref.read(authControllerProvider.notifier).unlockWithBiometrics();
    if (success && mounted) {
      context.go('/home');
    }
  }

  void _onDigitPress(String digit) {
    if (_pin.length < 4) {
      setState(() {
        _pin += digit;
        _error = null;
      });
      
      if (_pin.length == 4) {
        _submit();
      }
    }
  }

  void _onDeletePress() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
        _error = null;
      });
    }
  }

  Future<void> _submit() async {
    setState(() => _isLoading = true);
    
    final success = await ref.read(authControllerProvider.notifier).unlockWithPin(_pin);
    
    if (mounted) {
      setState(() => _isLoading = false);
      if (success) {
        context.go('/home');
      } else {
        setState(() {
          _pin = '';
          _error = ref.read(authControllerProvider).errorMessage ?? 'Invalid PIN';
        });
      }
    }
  }

  Widget _buildDot(bool isFilled) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isFilled ? Theme.of(context).primaryColor : Colors.grey.shade300,
      ),
    );
  }

  Widget _buildKeypadButton(String text, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(24),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 28, color: Colors.black87),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final showBiometrics = authState.isBiometricEnabled && authState.canUseBiometrics;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 80),
            const Icon(Icons.lock_outline, size: 64, color: Colors.blue),
            const SizedBox(height: 24),
            const Text(
              'Enter PIN',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'To unlock SmartWallet',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return _buildDot(index < _pin.length);
              }),
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_error != null)
              Text(
                _error!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildKeypadButton('1', () => _onDigitPress('1')),
                      _buildKeypadButton('2', () => _onDigitPress('2')),
                      _buildKeypadButton('3', () => _onDigitPress('3')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildKeypadButton('4', () => _onDigitPress('4')),
                      _buildKeypadButton('5', () => _onDigitPress('5')),
                      _buildKeypadButton('6', () => _onDigitPress('6')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildKeypadButton('7', () => _onDigitPress('7')),
                      _buildKeypadButton('8', () => _onDigitPress('8')),
                      _buildKeypadButton('9', () => _onDigitPress('9')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      showBiometrics
                          ? TextButton(
                              onPressed: _authenticateBiometrics,
                              style: TextButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(24),
                              ),
                              child: const Icon(Icons.fingerprint, size: 32, color: Colors.blue),
                            )
                          : const SizedBox(width: 80), // Placeholder
                      _buildKeypadButton('0', () => _onDigitPress('0')),
                      TextButton(
                        onPressed: _onDeletePress,
                        style: TextButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(24),
                        ),
                        child: const Icon(Icons.backspace, size: 28, color: Colors.black87),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
