import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretium_app/screens/auth/login.dart';

import '../../core/providers/auth_provider.dart';
import '../../core/providers/provider.dart';
import '../accept_payment.dart';
import '../pay_bills_screen.dart';
import '../pay_direct_screen.dart';
import 'page_indicator.dart';

@RoutePage()
class OnboardingFlow extends ConsumerStatefulWidget {
  const OnboardingFlow({super.key});

  @override
  _HomeTabScreenState createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends ConsumerState<OnboardingFlow> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      log("i am here");
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
  Widget build(BuildContext context) {
    final pageController = PageController();
    final currentPage = ref.watch(onboardingProvider);

    ref.listen<int>(onboardingProvider, (previous, next) {
      if (next < 4) {
        pageController.animateToPage(
          next,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              DirectPayScreen(),
              AcceptPaymentsScreen(),
              PayBillsScreen(),
              LoginScreen(),
            ],
          ),
          if (currentPage < 3)
            Positioned(
              bottom: 110,
              left: 0,
              right: 0,
              child: OnboardingPageIndicator(
                currentPage: currentPage,
                pageCount: 3,
              ),
            ),
        ],
      ),
    );
  }
}
