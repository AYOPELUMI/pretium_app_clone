import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'auth_provider.dart';

final signUpFormProvider =
    StateNotifierProvider<SignUpFormNotifier, SignUpFormState>((ref) {
  return SignUpFormNotifier(ref);
});

class SignUpFormNotifier extends StateNotifier<SignUpFormState> {
  SignUpFormNotifier(this.ref) : super(SignUpFormState());
  final Ref ref;
  void updateFirstName(String value) {
    state = state.copyWith(firstName: value);
  }

  void updateLastName(String value) {
    state = state.copyWith(lastName: value);
  }

  void updateEmail(String value) {
    state = state.copyWith(email: value);
  }

  void updatePassword(String value) {
    state = state.copyWith(password: value);
  }

  void toggleTermsAccepted() {
    state = state.copyWith(termsAccepted: !state.termsAccepted);
  }

  Future<void> submit() async {
    if (!state.isValid) return;
    state = state.copyWith(status: FormStatus.submitting);

    try {
      await ref.read(authServiceProvider).signUp(
            firstName: state.firstName,
            lastName: state.lastName,
            email: state.email,
            password: state.password,
          );
      state = state.copyWith(status: FormStatus.success);
    } catch (e) {
      state =
          state.copyWith(status: FormStatus.error, errorMessage: e.toString());
    }
  }
}

@immutable
class SignUpFormState {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final bool termsAccepted;
  final FormStatus status;
  final String? errorMessage;

  const SignUpFormState({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.termsAccepted = false,
    this.status = FormStatus.initial,
    this.errorMessage,
  });

  bool get isValid =>
      firstName.isNotEmpty &&
      lastName.isNotEmpty &&
      EmailValidator.validate(email) &&
      password.length >= 6 &&
      termsAccepted;

  SignUpFormState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    bool? termsAccepted,
    FormStatus? status,
    String? errorMessage,
  }) {
    return SignUpFormState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      termsAccepted: termsAccepted ?? this.termsAccepted,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

enum FormStatus { initial, submitting, success, error }
