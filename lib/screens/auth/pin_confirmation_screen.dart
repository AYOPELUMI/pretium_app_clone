// lib/features/auth/screens/pin_confirmation_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/auth_provider.dart';
import '../dashboard/dashboard_screen.dart';

class PinConfirmationScreen extends ConsumerStatefulWidget {
  const PinConfirmationScreen({super.key});

  @override
  ConsumerState<PinConfirmationScreen> createState() => _PinConfirmationScreenState();
}

class _PinConfirmationScreenState extends ConsumerState<PinConfirmationScreen> {
  String _enteredPin = '';

  void _onNumberPressed(String number) {
    if (_enteredPin.length < 4) {
      setState(() {
        _enteredPin += number;
      });
    }
    
    if (_enteredPin.length == 4) {
      _verifyPin();
    }
  }

  Future<void> _verifyPin() async {
    final isValid = await ref.read(authServiceProvider).verifyPin(_enteredPin);
    if (isValid) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    } else {
      setState(() {
        _enteredPin = '';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid PIN. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Re-enter your PIN to confirm',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Your PIN will be required to access the app',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index < _enteredPin.length
                          ? Theme.of(context).primaryColor
                          : Colors.grey.withOpacity(0.3),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 60),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              childAspectRatio: 1.5,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(9, (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () => _onNumberPressed('${index + 1}'),
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}