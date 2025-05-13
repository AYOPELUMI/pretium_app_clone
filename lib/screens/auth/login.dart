import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:email_validator/email_validator.dart';
import 'package:pretium_app/core/res/constants.dart';
import 'package:pretium_app/core/res/gap.dart';
import 'package:pretium_app/core/res/theme.dart';
import 'package:pretium_app/core/router/router.gr.dart';
import 'package:sizer/sizer.dart';

import '../../core/providers/auth_provider.dart';
import '../../core/providers/login_provider.dart';
import '../../core/providers/sign_up_provider.dart';
import '../../core/res/images.dart';
import '../../widgets/onboarding_button.dart';
import '../../widgets/render_svg.dart';
import '../../widgets/text_field.dart';
import '../dashboard/dashboard_screen.dart';
import 'sign_up.dart';

@RoutePage()
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isSubmitted = false;

  void initState() {
    super.initState();
    Future.microtask(() {
      final authState = ref.read(authStateProvider);
      authState.whenOrNull(
        data: (isLoggedIn) {
          FlutterNativeSplash.remove();
        },
        error: (_, __) {
          FlutterNativeSplash.remove();
        },
      );
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
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

  void _submit() async {
    setState(() => _isSubmitted = true);

    if (_formKey.currentState!.validate()) {
      final notifier = ref.read(loginFormProvider.notifier);
      try {
        await notifier.submit();
        ref.read(authStateProvider).when(
              data: (authState) {
                if (authState.isAuthenticated) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.router.replaceAll([HomeTabRoute()]);
                  });
                }
              },
              loading: () {},
              error: (error, stack) {
                // Handle auth state errors if needed
              },
            );

        context.router.replaceAll([HomeTabRoute()]);
      } catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginFormProvider);
    final notifier = ref.read(loginFormProvider.notifier);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                100.verticalSpacing,
                IntrinsicWidth(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: context.theme.primaryColor.withOpacity(0.2)),
                    child: RenderSvg(
                      svgPath: PretiumImages.wallet_svg,
                      useIcon: true,
                      svgHeight: 30,
                      svgWidth: 30,
                    ),
                  ),
                ),
                32.verticalSpacing,
                Text('Welcome Back!', style: title()),
                const SizedBox(height: 8),
                Text(
                  'Sign in to continue',
                  style: subText(),
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  labelText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
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
                Row(
                  children: [
                    Checkbox(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      value: state.rememberMe,
                      onChanged: (_) => notifier.toggleRememberMe(),
                    ),
                    Text('Remember me', style: TextStyle(fontSize: 12.sp)),
                    24.verticalSpacing,
                    TextButton(
                      onPressed: () {
                        // Navigate to forgot password screen
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp),
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
                      ? "Logging in..."
                      : 'Login',
                ),
                const SizedBox(height: 16),
                textBelow(
                  context: context,
                  description: "Don't have an account?  ",
                  onTap: () {
                    context.router.push(SignUpRoute());
                  },
                  actonWord: 'Sign Up',
                )
              ]),
        ),
      ),
    );
  }
}
