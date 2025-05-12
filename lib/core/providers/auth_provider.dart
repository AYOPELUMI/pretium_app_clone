// lib/services/auth_service.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthService {
  final Ref ref;
  AuthService(this.ref);

  // Mock user data for demo purposes
  final mockUser = {
    'email': 'user@example.com',
    'password': 'password123',
    'firstName': 'Oluwapelumi',
    'lastName': 'User',
  };

  // Mock API calls - replace with actual backend calls
  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    // In real app, make HTTP request to your backend
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network call

    // Demo validation - replace with actual backend call
    if (email == mockUser['email'] && password == mockUser['password']) {
      return {
        'success': true,
        'user': {
          'email': email,
          'firstName': mockUser['firstName'],
          'lastName': mockUser['lastName'],
        },
      };
    } else {
      throw Exception('Invalid email or password');
    }
  }

  Future<void> verifyEmail({required String code}) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<bool> verifyPin(String pin) async {
    await Future.delayed(const Duration(seconds: 1));
    return pin.length == 4; // Simple validation for demo
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref);
});

// lib/app/providers/auth_state_provider.dart
final authStateProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  return AuthStateNotifier(ref);
});

class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier(this.ref) : super(AuthState.initial());
  final Ref ref;
  Future<void> login(String email, String password) async {
    state = AuthState.loading();
    try {
      final response = await ref.read(authServiceProvider).login(
            email: email,
            password: password,
          );
      state = AuthState.authenticated(response['user']);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  void logout() {
    state = AuthState.initial();
  }
}

class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final String? error;
  final Map<String, dynamic>? user;

  AuthState({
    required this.isAuthenticated,
    required this.isLoading,
    this.error,
    this.user,
  });

  factory AuthState.initial() => AuthState(
        isAuthenticated: false,
        isLoading: false,
      );

  factory AuthState.loading() => AuthState(
        isAuthenticated: false,
        isLoading: true,
      );

  factory AuthState.authenticated(Map<String, dynamic> user) => AuthState(
        isAuthenticated: true,
        isLoading: false,
        user: user,
      );

  factory AuthState.error(String error) => AuthState(
        isAuthenticated: false,
        isLoading: false,
        error: error,
      );
}
