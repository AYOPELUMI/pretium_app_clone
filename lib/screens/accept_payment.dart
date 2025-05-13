import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretium_app/core/res/gap.dart';
import 'package:pretium_app/core/res/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../animations/animation.dart';
import '../core/providers/onboarding_provider.dart';
import '../core/providers/provider.dart';
import '../core/res/constants.dart';
import '../core/res/images.dart';
import '../widgets/onboarding_button.dart';
import '../widgets/render_svg.dart';

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SkipWidget(
                onTap: () async {
                  ref.read(onboardingProvider.notifier).goToPage(3);
                  ref.read(onboardingCompletedProvider.notifier).state = true;
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('onboarding_completed', true);
                },
              ),
              const Spacer(),
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
                'Accept Payments',
                style: title(),
              ),
              const SizedBox(height: 16),
              Text(
                'Accept stablecoin payments hassle-free',
                style: subText(),
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
