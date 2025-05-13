import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:email_validator/email_validator.dart';
import 'package:pretium_app/core/res/gap.dart';
import 'package:pretium_app/screens/auth/verification_screen.dart';
import 'package:sizer/sizer.dart';

import '../../core/providers/sign_up_provider.dart';
import '../../core/res/constants.dart';
import '../../widgets/onboarding_button.dart';
import '../../widgets/text_field.dart';
import 'login.dart';

@RoutePage()
class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSubmitted = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your first name';
    }
    return null;
  }

  String? _validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your last name';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!EmailValidator.validate(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  void _submit() {
    setState(() => _isSubmitted = true);
    log("true");

    if (_formKey.currentState!.validate()) {
      log("true");
      final notifier = ref.read(signUpFormProvider.notifier);
      notifier.submit();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signUpFormProvider);
    final notifier = ref.read(signUpFormProvider.notifier);

    ref.listen<SignUpFormState>(signUpFormProvider, (previous, next) {
      if (next.status == FormStatus.success) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const VerifyAccountScreen(),
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Create Account',
                style: title(),
              ),
              const SizedBox(height: 8),
              Text(
                'Simplify your crypto payments with us',
                style: subText(),
              ),
              const SizedBox(height: 40),
              CustomTextField(
                controller: _firstNameController,
                hintText: 'First Name',
                labelText: 'First Name',
                prefixIcon: Icons.person_outline,
                onChanged: notifier.updateFirstName,
                validator: _validateFirstName,
                autovalidateMode: _isSubmitted
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _lastNameController,
                hintText: 'Last Name',
                labelText: 'Last Name',
                prefixIcon: Icons.person_outline,
                onChanged: notifier.updateLastName,
                validator: _validateLastName,
                autovalidateMode: _isSubmitted
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _emailController,
                hintText: 'Email',
                labelText: 'Email',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                onChanged: notifier.updateEmail,
                validator: _validateEmail,
                autovalidateMode: _isSubmitted
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _passwordController,
                hintText: 'Password',
                labelText: 'Password',
                prefixIcon: Icons.lock_outline,
                obscureText: true,
                showPasswordToggle: true,
                onChanged: notifier.updatePassword,
                validator: _validatePassword,
                autovalidateMode: _isSubmitted
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        value: state.termsAccepted,
                        onChanged: (_) => notifier.toggleTermsAccepted(),
                      ),
                      Text(
                        'Accept Terms and Conditions',
                        style: TextStyle(
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  if (_isSubmitted && !state.termsAccepted)
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: Text(
                        'You must accept the terms',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ),
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
              OnboardingButton(
                onPressed:
                    state.status == FormStatus.submitting ? () {} : _submit,
                isLoading: state.status == FormStatus.submitting,
                text: state.status == FormStatus.submitting
                    ? "Creating account..."
                    : 'Create Account',
              ),
              const SizedBox(height: 16),
              textBelow(
                  description: "Already have an account? ",
                  actonWord: "Login",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  context: context),
              12.verticalSpacing,
            ],
          ),
        ),
      ),
    );
  }
}
