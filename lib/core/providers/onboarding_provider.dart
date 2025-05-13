import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_provider.dart';

final onboardingCompletedProvider = StateProvider<bool>((ref) {
  final prefsAsync = ref.watch(sharedPreferencesProvider);

  // Handle the async loading state
  return prefsAsync.when(
    loading: () => false, // Default value while loading
    error: (error, stack) => false, // Default value if error occurs
    data: (prefs) => prefs.getBool('onboarding_completed') ?? false,
  );
});
