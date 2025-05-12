import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

import 'core/providers/auth_provider.dart';
import 'core/providers/provider.dart';
import 'screens/auth/login.dart';
import 'screens/auth/pin_confirmation_screen.dart';
import 'screens/auth/sign_up.dart';
import 'screens/auth/verification_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/onboarding/onboarding_flow.dart';

void main() async {
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.watch(appThemeProvider);
    final authState = ref.watch(authStateProvider);
    return Sizer(builder:
        (BuildContext context, Orientation orientation, DeviceType deviceType) {
      return MaterialApp(
        title: 'Pretium',
        debugShowCheckedModeBanner: false,
        theme: appTheme.lightTheme,
        darkTheme: appTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: authState.isAuthenticated
            ? const DashboardScreen()
            : const OnboardingFlow(),
        routes: {
          '/onboarding': (context) => const OnboardingFlow(),
          '/signup': (context) => const SignUpScreen(),
          '/login': (context) => const LoginScreen(),
          '/verify': (context) => const VerifyAccountScreen(),
          '/pin': (context) => const PinConfirmationScreen(),
          '/dashboard': (context) => const DashboardScreen(),
        },
      );
    });
  }
}
