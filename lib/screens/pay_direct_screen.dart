import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../animations/animation.dart';
import '../core/providers/provider.dart';
import '../widgets/onboarding_button.dart';

class DirectPayScreen extends ConsumerWidget {
  const DirectPayScreen({super.key});

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
                  onPressed: () =>
                      ref.read(onboardingProvider.notifier).goToPage(3),
                  child: const Text('Skip'),
                ),
              ),
              const Spacer(),
              const Text(
                'Direct Pay',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Pay with crypto across Africa effortlessly',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const Spacer(),
              OnboardingButton(
                text: 'Next',
                onPressed: () =>
                    ref.read(onboardingProvider.notifier).nextPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
