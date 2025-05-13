import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'core/providers/auth_provider.dart';
import 'core/providers/provider.dart';
import 'core/router/router.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Initialize SharedPreferences early
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWith((ref) => sharedPreferences),
      ],
      child: const MyApp(),
    ),
  );
}

final router = Provider((ref) => AppRouter(ref));

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.watch(appThemeProvider);
    return Sizer(builder:
        (BuildContext context, Orientation orientation, DeviceType deviceType) {
      return MaterialApp.router(
        title: 'Pretium',
        debugShowCheckedModeBanner: false,
        theme: appTheme.lightTheme,
        darkTheme: appTheme.darkTheme,
        themeMode: ThemeMode.light,
        routerConfig: ref.watch(router).config(
              reevaluateListenable: ReevaluateListenable.stream(
                ref.watch(authStateProvider.stream),
              ),
              navigatorObservers: () => [
                AppRouterObserver(ref),
              ],
            ),
        builder: (context, child) {
          return child!;
        },
      );
    });
  }
}
