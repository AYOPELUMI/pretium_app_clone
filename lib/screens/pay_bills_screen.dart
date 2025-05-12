import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../animations/animation.dart';
import '../core/providers/provider.dart';
import '../widgets/onboarding_button.dart';

class PayBillsScreen extends ConsumerWidget {
  const PayBillsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SlideTransitionAnimation(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () => ref.read(onboardingProvider.notifier).goToPage(3),
                  child: const Text('Skip'),
                ),
              ),
              const Spacer(),
              const Text(
                'Pay Bills',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Pay for utility services and earn rewards',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const Spacer(),
              OnboardingButton(
                text: 'Get Started',
                onPressed: () => ref.read(onboardingProvider.notifier).nextPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}