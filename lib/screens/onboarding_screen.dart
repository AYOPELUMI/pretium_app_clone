import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../animations/animation.dart';
import '../core/providers/provider.dart';
import '../widgets/onboarding_button.dart';

class AcceptPaymentsScreen extends ConsumerWidget {
  const AcceptPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SlideTransitionAnimation(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              const Text(
                'Accept Payments',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Accept stablecoin payments hassle-free',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: OnboardingButton(
                  text: 'Next',
                  onPressed: () =>
                      ref.read(onboardingProvider.notifier).nextPage(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
