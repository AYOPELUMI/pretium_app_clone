import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretium_app/core/res/constants.dart';
import 'package:pretium_app/core/router/router.gr.dart';
import '../providers/auth_provider.dart';
import '../providers/onboarding_provider.dart';

@AutoRouterConfig(replaceInRouteName: 'Route,')
class AppRouter extends $AppRouter {
  final Ref _ref;

  AppRouter(this._ref);

  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: OnboardingFlow.page,
          initial: !_ref.read(onboardingCompletedProvider),
        ),
        AutoRoute(
            page: LoginRoute.page,
            initial: _ref.read(onboardingCompletedProvider)),
        AutoRoute(page: SignUpRoute.page),
        AutoRoute(page: PinConfirmationRoute.page),
        AutoRoute(page: VerifyAccountRoute.page),
        AutoRoute(
          page: HomeTabRoute.page,
          children: [
            AutoRoute(page: DashboardRoute.page),
            AutoRoute(page: RecentTransactionsRoute.page)
          ],
          guards: [AuthGuard(_ref)],
        ),
      ];
}

class AppRouterObserver extends AutoRouterObserver {
  final WidgetRef ref;

  AppRouterObserver(this.ref);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route.settings.name == null) return;
    log('Pushed ${route.settings.name}', name: 'RouteObserver');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route.settings.name == null) return;
    log('Popped ${route.settings.name}', name: 'RouteObserver');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {}
}

class AuthGuard extends AutoRouteGuard {
  final Ref ref;

  AuthGuard(this.ref);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final authState = ref.read(authStateProvider);

    // Check onboarding completion

    final onboardingCompleted = ref.read(onboardingCompletedProvider);
    log(onboardingCompleted.toString());

    if (!onboardingCompleted) {
      resolver.next(); // Allow onboarding to show
      return;
    }

    dismissKeyboard();

    // if (authState.requireValue == true) {
    resolver.next(); // Allow navigation to home
    // } else {
    //   router.replaceAll([const LoginRoute()]); // Clear stack and go to login
    // }
  }
}
