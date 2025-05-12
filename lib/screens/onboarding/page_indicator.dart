import 'package:flutter/material.dart';
import 'package:pretium_app/core/res/theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPageIndicator extends StatelessWidget {
  final int currentPage;
  final int pageCount;

  const OnboardingPageIndicator({
    super.key,
    required this.currentPage,
    required this.pageCount,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SmoothPageIndicator(
        controller: PageController(initialPage: currentPage),
        count: pageCount,
        effect: ExpandingDotsEffect(
          expansionFactor: 3,
          dotHeight: 8,
          dotWidth: 8,
          activeDotColor: context.theme.primaryColor,
          dotColor: Colors.grey,
          spacing: 8, // Space between dots
        ),
      ),
    );
  }
}
