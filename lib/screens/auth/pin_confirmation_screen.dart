// lib/features/auth/screens/pin_confirmation_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretium_app/core/res/gap.dart';
import 'package:pretium_app/core/res/theme.dart';
import 'package:sizer/sizer.dart';

import '../../core/providers/auth_provider.dart';
import '../dashboard/dashboard_screen.dart';


@RoutePage()
class PinConfirmationScreen extends ConsumerStatefulWidget {
  final String? initialPin; // For confirmation step
  final bool isConfirming; // To distinguish between entry and confirmation

  const PinConfirmationScreen({
    super.key,
    this.initialPin,
    this.isConfirming = false,
  });

  @override
  ConsumerState<PinConfirmationScreen> createState() =>
      _PinConfirmationScreenState();
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
      if (widget.isConfirming) {
        _verifyPin();
      } else {
        // Move to confirmation screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PinConfirmationScreen(
              initialPin: _enteredPin,
              isConfirming: true,
            ),
          ),
        );
      }
    }
  }

  void _onBackspacePressed() {
    if (_enteredPin.isNotEmpty) {
      setState(() {
        _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
      });
    }
  }

  Future<void> _verifyPin() async {
    if (_enteredPin == widget.initialPin) {
      // PINs match - save and proceed
      final success =
          await ref.read(authServiceProvider).verifyPin(_enteredPin);
      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      } else {
        _showError('Failed to save PIN. Please try again.');
      }
    } else {
      _showError('PINs do not match. Please try again.');
      // Go back to initial PIN entry
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PinConfirmationScreen()),
      );
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock,
              color: Colors.white,
              size: 40,
            ),
            16.verticalSpacing,
            Text(
              widget.isConfirming
                  ? 'Re-enter your PIN to confirm'
                  : 'Enter your new PIN',
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white),
                      shape: BoxShape.circle,
                      color: index < _enteredPin.length
                          ? Colors.white
                          : Colors.transparent,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            Text(
              'Your PIN will be required to access the app',
              style: TextStyle(fontSize: 11.sp, color: Colors.white),
            ),
            const SizedBox(height: 60),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              childAspectRatio: 1.5,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // Number buttons 1-9
                ...List.generate(9, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () => _onNumberPressed('${index + 1}'),
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }),
                // Empty cell
                const SizedBox.shrink(),
                // 0 button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () => _onNumberPressed('0'),
                    child: const Text(
                      '0',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // Backspace button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: _onBackspacePressed,
                    icon: const Icon(
                      Icons.backspace,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
