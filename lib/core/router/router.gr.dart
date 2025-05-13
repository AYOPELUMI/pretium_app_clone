// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;
import 'package:pretium_app/screens/auth/login.dart' as _i3;
import 'package:pretium_app/screens/auth/pin_confirmation_screen.dart' as _i5;
import 'package:pretium_app/screens/auth/sign_up.dart' as _i7;
import 'package:pretium_app/screens/auth/verification_screen.dart' as _i8;
import 'package:pretium_app/screens/dashboard/dashboard_screen.dart' as _i1;
import 'package:pretium_app/screens/home/home.dart' as _i2;
import 'package:pretium_app/screens/home/recent_transactions_screen.dart'
    as _i6;
import 'package:pretium_app/screens/onboarding/onboarding_flow.dart' as _i4;

abstract class $AppRouter extends _i9.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    DashboardRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.DashboardScreen(),
      );
    },
    HomeTabRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeTabScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.LoginScreen(),
      );
    },
    OnboardingFlow.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.OnboardingFlow(),
      );
    },
    PinConfirmationRoute.name: (routeData) {
      final args = routeData.argsAs<PinConfirmationRouteArgs>(
          orElse: () => const PinConfirmationRouteArgs());
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.PinConfirmationScreen(
          key: args.key,
          initialPin: args.initialPin,
          isConfirming: args.isConfirming,
        ),
      );
    },
    RecentTransactionsRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.RecentTransactionsScreen(),
      );
    },
    SignUpRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.SignUpScreen(),
      );
    },
    VerifyAccountRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.VerifyAccountScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.DashboardScreen]
class DashboardRoute extends _i9.PageRouteInfo<void> {
  const DashboardRoute({List<_i9.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomeTabScreen]
class HomeTabRoute extends _i9.PageRouteInfo<void> {
  const HomeTabRoute({List<_i9.PageRouteInfo>? children})
      : super(
          HomeTabRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeTabRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LoginScreen]
class LoginRoute extends _i9.PageRouteInfo<void> {
  const LoginRoute({List<_i9.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i4.OnboardingFlow]
class OnboardingFlow extends _i9.PageRouteInfo<void> {
  const OnboardingFlow({List<_i9.PageRouteInfo>? children})
      : super(
          OnboardingFlow.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingFlow';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i5.PinConfirmationScreen]
class PinConfirmationRoute extends _i9.PageRouteInfo<PinConfirmationRouteArgs> {
  PinConfirmationRoute({
    _i10.Key? key,
    String? initialPin,
    bool isConfirming = false,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          PinConfirmationRoute.name,
          args: PinConfirmationRouteArgs(
            key: key,
            initialPin: initialPin,
            isConfirming: isConfirming,
          ),
          initialChildren: children,
        );

  static const String name = 'PinConfirmationRoute';

  static const _i9.PageInfo<PinConfirmationRouteArgs> page =
      _i9.PageInfo<PinConfirmationRouteArgs>(name);
}

class PinConfirmationRouteArgs {
  const PinConfirmationRouteArgs({
    this.key,
    this.initialPin,
    this.isConfirming = false,
  });

  final _i10.Key? key;

  final String? initialPin;

  final bool isConfirming;

  @override
  String toString() {
    return 'PinConfirmationRouteArgs{key: $key, initialPin: $initialPin, isConfirming: $isConfirming}';
  }
}

/// generated route for
/// [_i6.RecentTransactionsScreen]
class RecentTransactionsRoute extends _i9.PageRouteInfo<void> {
  const RecentTransactionsRoute({List<_i9.PageRouteInfo>? children})
      : super(
          RecentTransactionsRoute.name,
          initialChildren: children,
        );

  static const String name = 'RecentTransactionsRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i7.SignUpScreen]
class SignUpRoute extends _i9.PageRouteInfo<void> {
  const SignUpRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i8.VerifyAccountScreen]
class VerifyAccountRoute extends _i9.PageRouteInfo<void> {
  const VerifyAccountRoute({List<_i9.PageRouteInfo>? children})
      : super(
          VerifyAccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'VerifyAccountRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}
