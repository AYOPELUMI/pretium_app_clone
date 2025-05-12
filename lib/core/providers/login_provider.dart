// lib/features/auth/providers/login_providers.dart
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_provider.dart';
import 'sign_up_provider.dart';

final loginFormProvider =
    StateNotifierProvider<LoginFormNotifier, LoginFormState>((ref) {
  return LoginFormNotifier(ref);
});

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  LoginFormNotifier(this.ref) : super(LoginFormState());
  final Ref ref;

  void updateEmail(String value) {
    state = state.copyWith(email: value);
  }

  void updatePassword(String value) {
    state = state.copyWith(password: value);
  }

  void toggleRememberMe() {
    state = state.copyWith(rememberMe: !state.rememberMe);
  }

  Future<void> submit() async {
    if (!state.isValid) return;
    state = state.copyWith(status: FormStatus.submitting);

    try {
      final response = await ref.read(authServiceProvider).login(
            email: state.email,
            password: state.password,
          );

      // Handle successful login
      state = state.copyWith(
        status: FormStatus.success,
        user: response['user'],
      );

      // Navigate to dashboard or next screen
      // This would typically be handled by a listener in the widget
    } catch (e) {
      state = state.copyWith(
        status: FormStatus.error,
        errorMessage: e.toString(),
      );
    }
  }
}

@immutable
class LoginFormState {
  final String email;
  final String password;
  final bool rememberMe;
  final FormStatus status;
  final String? errorMessage;
  final Map<String, dynamic>? user;

  const LoginFormState({
    this.email = '',
    this.password = '',
    this.rememberMe = false,
    this.status = FormStatus.initial,
    this.errorMessage,
    this.user,
  });

  bool get isValid => EmailValidator.validate(email) && password.isNotEmpty;

  LoginFormState copyWith({
    String? email,
    String? password,
    bool? rememberMe,
    FormStatus? status,
    String? errorMessage,
    Map<String, dynamic>? user,
  }) {
    return LoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }
}
