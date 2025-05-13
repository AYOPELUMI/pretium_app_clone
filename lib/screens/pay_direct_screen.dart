import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretium_app/core/res/constants.dart';
import 'package:pretium_app/core/res/gap.dart';
import 'package:pretium_app/core/res/images.dart';
import 'package:pretium_app/core/res/theme.dart';
import 'package:pretium_app/widgets/render_svg.dart';
import 'package:sizer/sizer.dart';

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
              const Spacer(),
              32.verticalSpacing,
              Container(
                padding: EdgeInsets.all(12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.theme.primaryColor.withOpacity(0.2)),
                child: RenderSvg(
                  svgPath: PretiumImages.card_svg,
                  useIcon: true,
                  svgHeight: 60,
                  svgWidth: 60,
                ),
              ),
              32.verticalSpacing,
              Text(
                'Direct Pay',
                style: title(),
              ),
              const SizedBox(height: 16),
              Text('Pay with crypto across Africa effortlessly',
                  style: subText()),
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
