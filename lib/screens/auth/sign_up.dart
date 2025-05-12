// lib/features/auth/screens/sign_up_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:email_validator/email_validator.dart';

import '../../core/providers/sign_up_provider.dart';
import '../../widgets/text_field.dart';
import 'login.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signUpFormProvider);
    final notifier = ref.read(signUpFormProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              const Text(
                'Create Account',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Simplify your crypto payments with us',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 40),
              CustomTextField(
                hintText: 'First Name',
                onChanged: notifier.updateFirstName,
                errorText:
                    state.firstName.isEmpty && state.status == FormStatus.error
                        ? 'Please enter your first name'
                        : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: 'Last Name',
                onChanged: notifier.updateLastName,
                errorText:
                    state.lastName.isEmpty && state.status == FormStatus.error
                        ? 'Please enter your last name'
                        : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                onChanged: notifier.updateEmail,
                errorText: !EmailValidator.validate(state.email) &&
                        state.status == FormStatus.error
                    ? 'Please enter a valid email'
                    : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: 'Password',
                obscureText: true,
                onChanged: notifier.updatePassword,
                errorText: state.password.length < 6 &&
                        state.status == FormStatus.error
                    ? 'Password must be at least 6 characters'
                    : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: state.termsAccepted,
                    onChanged: (_) => notifier.toggleTermsAccepted(),
                  ),
                  const Text('Accept Terms and Conditions'),
                ],
              ),
              if (state.status == FormStatus.error &&
                  state.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    state.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: state.status == FormStatus.submitting
                      ? null
                      : () => notifier.submit(),
                  child: state.status == FormStatus.submitting
                      ? const CircularProgressIndicator()
                      : const Text('Create Account'),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text('Already have an account? Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
