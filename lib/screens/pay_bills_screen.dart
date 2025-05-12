import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretium_app/core/res/gap.dart';
import 'package:pretium_app/core/res/theme.dart';

import '../animations/animation.dart';
import '../core/providers/provider.dart';
import '../core/res/constants.dart';
import '../core/res/images.dart';
import '../widgets/onboarding_button.dart';
import '../widgets/render_svg.dart';

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
              SkipWidget(
                  onTap: () =>
                      ref.read(onboardingProvider.notifier).goToPage(3)),
              const Spacer(),
              Container(
                padding: EdgeInsets.all(12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.theme.primaryColor.withOpacity(0.2)),
                child: RenderSvg(
                  svgPath: PretiumImages.bills_svg,
                  useIcon: true,
                  svgHeight: 60,
                  svgWidth: 60,
                ),
              ),
              32.verticalSpacing,
              Text(
                'Pay Bills',
                style: title(),
              ),
              const SizedBox(height: 16),
              Text(
                'Pay for utility services and earn rewards',
                style: subText(),
              ),
              const Spacer(),
              OnboardingButton(
                text: 'Get Started',
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
