import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_wallet/features/auth/presentation/providers/auth_provider.dart';

class PinSetupScreen extends ConsumerStatefulWidget {
  const PinSetupScreen({super.key});

  @override
  ConsumerState<PinSetupScreen> createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends ConsumerState<PinSetupScreen> {
  String _pin = '';
  String _confirmPin = '';
  bool _isConfirming = false;
  String? _error;

  void _onDigitPress(String digit) {
    setState(() {
      _error = null;
      if (!_isConfirming) {
        if (_pin.length < 4) _pin += digit;
        if (_pin.length == 4) {
          Future.delayed(const Duration(milliseconds: 200), () {
            setState(() => _isConfirming = true);
          });
        }
      } else {
        if (_confirmPin.length < 4) _confirmPin += digit;
        if (_confirmPin.length == 4) {
          _submit();
        }
      }
    });
  }

  void _onDeletePress() {
    setState(() {
      _error = null;
      if (!_isConfirming) {
        if (_pin.isNotEmpty) _pin = _pin.substring(0, _pin.length - 1);
      } else {
        if (_confirmPin.isNotEmpty) {
          _confirmPin = _confirmPin.substring(0, _confirmPin.length - 1);
        } else {
          _isConfirming = false;
          _pin = '';
        }
      }
    });
  }

  Future<void> _submit() async {
    if (_pin != _confirmPin) {
      setState(() {
        _error = 'PINs do not match. Try again.';
        _pin = '';
        _confirmPin = '';
        _isConfirming = false;
      });
      return;
    }

    final success = await ref.read(authControllerProvider.notifier).setupPin(_pin);
    if (success && mounted) {
      context.go('/home');
    } else {
      setState(() {
        _error = ref.read(authControllerProvider).errorMessage;
        _pin = '';
        _confirmPin = '';
        _isConfirming = false;
      });
    }
  }

  void _skip() {
    context.go('/home');
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
    final currentPin = _isConfirming ? _confirmPin : _pin;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Setup PIN'),
        actions: [
          TextButton(
            onPressed: _skip,
            child: const Text('Skip'),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Text(
              _isConfirming ? 'Confirm your PIN' : 'Create a 4-digit PIN',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'To secure your SmartWallet',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return _buildDot(index < currentPin.length);
              }),
            ),
            const SizedBox(height: 20),
            if (_error != null)
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
                      const SizedBox(width: 80), // Placeholder
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
