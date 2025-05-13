import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  final Ref _ref;

  AppRouter(this._ref);

  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  List<AutoRoute> get routes => [];
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
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    log("i got here");
    final isAuthenticated =
        ref.read(authStateProvider).isAuthenticated ?? false;

    if (isAuthenticated) {
      resolver.next(); // Allow navigation
    } else {
      // router.push(const Lo()); // Redirect to login
    }
  }
}
