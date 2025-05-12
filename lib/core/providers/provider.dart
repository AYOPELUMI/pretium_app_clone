import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../res/theme.dart';

final appThemeProvider = Provider<PretiumTheme>((ref) => PretiumTheme());

final onboardingProvider =
    StateNotifierProvider<OnboardingNotifier, int>((ref) {
  return OnboardingNotifier();
});

class OnboardingNotifier extends StateNotifier<int> {
  OnboardingNotifier() : super(0);

  void nextPage() => state++;
  void previousPage() => state--;
  void goToPage(int index) => state = index;
}
