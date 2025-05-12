import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:email_validator/email_validator.dart';
import 'package:pretium_app/core/res/constants.dart';
import 'package:pretium_app/core/res/gap.dart';
import 'package:pretium_app/core/res/theme.dart';

import '../../core/providers/login_provider.dart';
import '../../core/providers/sign_up_provider.dart';
import '../../core/res/images.dart';
import '../../widgets/onboarding_button.dart';
import '../../widgets/render_svg.dart';
import '../../widgets/text_field.dart';
import '../dashboard/dashboard_screen.dart';
import 'sign_up.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginFormProvider);
    final notifier = ref.read(loginFormProvider.notifier);

    // Listen for successful login
    ref.listen<LoginFormState>(loginFormProvider, (previous, next) {
      if (next.status == FormStatus.success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      }
    });

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              Container(
                padding: EdgeInsets.all(24),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.theme.primaryColor.withOpacity(0.2)),
                child: RenderSvg(
                  svgPath: PretiumImages.wallet_svg,
                  useIcon: true,
                  svgHeight: 30,
                  svgWidth: 30,
                ),
              ),
              32.verticalSpacing,
              Text(
                'Welcome Back!',
                style: title(),
              ),
              const SizedBox(height: 8),
              const Text(
                'Sign in to continue',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 40),
              CustomTextField(
                controller: _emailController,
                hintText: 'Email',
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.email_outlined,
                onChanged: notifier.updateEmail,
                errorText: !EmailValidator.validate(state.email) &&
                        state.status == FormStatus.error
                    ? 'Please enter a valid email'
                    : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _passwordController,
                hintText: 'Password',
                labelText: 'Password',
                prefixIcon: Icons.lock_outline,
                obscureText: true,
                onChanged: notifier.updatePassword,
                errorText:
                    state.password.isEmpty && state.status == FormStatus.error
                        ? 'Please enter your password'
                        : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: state.rememberMe,
                    onChanged: (_) => notifier.toggleRememberMe(),
                  ),
                  const Text('Remember me'),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      // Navigate to forgot password screen
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: context.theme.primaryColor,
                        fontWeight: FontWeight.w600,
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
                onPressed: state.status == FormStatus.submitting
                    ? () {}
                    : () => notifier.submit(),
                isLoading: state.status == FormStatus.submitting,
                text: state.status == FormStatus.submitting
                    ? "Logging in ..."
                    : 'Login',
              ),
              const SizedBox(height: 16),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  },
                  child: RichText(
                    text: const TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
