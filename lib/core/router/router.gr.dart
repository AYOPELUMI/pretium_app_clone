// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:pretium_app/screens/auth/login.dart' as _i1;
import 'package:pretium_app/screens/auth/pin_confirmation_screen.dart' as _i3;
import 'package:pretium_app/screens/auth/sign_up.dart' as _i4;
import 'package:pretium_app/screens/auth/verification_screen.dart' as _i5;
import 'package:pretium_app/screens/onboarding/onboarding_flow.dart' as _i2;

/// generated route for
/// [_i1.LoginScreen]
class LoginRoute extends _i6.PageRouteInfo<void> {
  const LoginRoute({List<_i6.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i1.LoginScreen();
    },
  );
}

/// generated route for
/// [_i2.OnboardingFlow]
class OnboardingFlow extends _i6.PageRouteInfo<void> {
  const OnboardingFlow({List<_i6.PageRouteInfo>? children})
      : super(
          OnboardingFlow.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingFlow';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i2.OnboardingFlow();
    },
  );
}

/// generated route for
/// [_i3.PinConfirmationScreen]
class PinConfirmationRoute extends _i6.PageRouteInfo<PinConfirmationRouteArgs> {
  PinConfirmationRoute({
    _i7.Key? key,
    String? initialPin,
    bool isConfirming = false,
    List<_i6.PageRouteInfo>? children,
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

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PinConfirmationRouteArgs>(
          orElse: () => const PinConfirmationRouteArgs());
      return _i3.PinConfirmationScreen(
        key: args.key,
        initialPin: args.initialPin,
        isConfirming: args.isConfirming,
      );
    },
  );
}

class PinConfirmationRouteArgs {
  const PinConfirmationRouteArgs({
    this.key,
    this.initialPin,
    this.isConfirming = false,
  });

  final _i7.Key? key;

  final String? initialPin;

  final bool isConfirming;

  @override
  String toString() {
    return 'PinConfirmationRouteArgs{key: $key, initialPin: $initialPin, isConfirming: $isConfirming}';
  }
}

/// generated route for
/// [_i4.SignUpScreen]
class SignUpRoute extends _i6.PageRouteInfo<void> {
  const SignUpRoute({List<_i6.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i4.SignUpScreen();
    },
  );
}

/// generated route for
/// [_i5.VerifyAccountScreen]
class VerifyAccountRoute extends _i6.PageRouteInfo<void> {
  const VerifyAccountRoute({List<_i6.PageRouteInfo>? children})
      : super(
          VerifyAccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'VerifyAccountRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i5.VerifyAccountScreen();
    },
  );
}
