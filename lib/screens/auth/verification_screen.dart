// lib/features/auth/screens/verify_account_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/text_field.dart';
import 'pin_confirmation_screen.dart';

class VerifyAccountScreen extends ConsumerStatefulWidget {
  const VerifyAccountScreen({super.key});

  @override
  ConsumerState<VerifyAccountScreen> createState() =>
      _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends ConsumerState<VerifyAccountScreen> {
  final _codeController = TextEditingController();
  String? _selectedCountry;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            const Text(
              'Verify Account',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Enter the verification code sent to your email',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            CustomTextField(
              controller: _codeController,
              hintText: 'Verification Code',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedCountry,
              decoration: InputDecoration(
                labelText: 'Select Country',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'Kenya', child: Text('Kenya')),
                DropdownMenuItem(value: 'Uganda', child: Text('Uganda')),
                DropdownMenuItem(value: 'Nigeria', child: Text('Nigeria')),
                DropdownMenuItem(value: 'Ghana', child: Text('Ghana')),
                DropdownMenuItem(value: 'Malawi', child: Text('Malawi')),
                DropdownMenuItem(value: 'Zambia', child: Text('Zambia')),
                DropdownMenuItem(value: 'Rwanda', child: Text('Rwanda')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedCountry = value;
                });
              },
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_codeController.text.isEmpty ||
                      _selectedCountry == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill all fields')),
                    );
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PinConfirmationScreen(),
                    ),
                  );
                },
                child: const Text('Verify Account'),
              ),
            ),
            const Spacer(),
            Center(
              child: TextButton(
                onPressed: () {
                  // Resend code logic
                },
                child: const Text(
                  "Didn't receive the code? Resend Code",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
