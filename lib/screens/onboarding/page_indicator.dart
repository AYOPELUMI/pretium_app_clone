import 'package:flutter/material.dart';
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
    return SmoothPageIndicator(
      controller: PageController(initialPage: currentPage),
      count: pageCount,
      effect: WormEffect(
        dotHeight: 8,
        dotWidth: 8,
        activeDotColor: Theme.of(context).primaryColor,
        dotColor: Colors.grey.withOpacity(0.5),
      ),
    );
  }
}
