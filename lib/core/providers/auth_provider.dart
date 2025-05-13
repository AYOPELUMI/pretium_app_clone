// lib/services/auth_service.dart
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider =
    FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

class AuthService {
  final Ref ref;
  AuthService(this.ref);

  static const _userKey = 'current_user';
  static const _usersKey = 'registered_users';

  Future<SharedPreferences> get _prefs async {
    return await ref.read(sharedPreferencesProvider.future);
  }

  final _authChanges = StreamController<Map<String, dynamic>?>.broadcast();

  Stream<Map<String, dynamic>?> get authChanges => _authChanges.stream;
  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    final prefs = await _prefs;
    final newUser = {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
    };

    final users = await getRegisteredUsers();

    if (users.any((u) => u['email'] == email)) {
      throw Exception('Email already registered');
    }

    users.add(newUser);
    await prefs.setString(_usersKey, _encodeUserList(users));
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final prefs = await _prefs;
    final users = await getRegisteredUsers();
    final user = users.firstWhere(
      (u) => u['email'] == email && u['password'] == password,
      orElse: () => {},
    );

    if (user.isEmpty) {
      throw Exception('Invalid email or password');
    }

    await prefs.setString(_userKey, _encodeUser(user));
    _authChanges.add(user); // Notify listeners
    return {
      'success': true,
      'user': user, // Return the user directly instead of fetching again
    };
  }

  Future<void> logout() async {
    final prefs = await _prefs;
    await prefs.remove(_userKey);
  }

  Future<bool> verifyPin(String pin) async {
    await Future.delayed(const Duration(seconds: 1));
    return pin.length == 4; // Simple validation for demo
  }

  Future<Map<String, dynamic>?> getCurrentUser() async {
    final prefs = await _prefs;
    final userString = prefs.getString(_userKey);
    if (userString == null) return null;
    return _decodeUser(userString);
  }

  Future<List<Map<String, dynamic>>> getRegisteredUsers() async {
    final prefs = await _prefs;
    final usersString = prefs.getString(_usersKey);
    if (usersString == null) return [];
    return _decodeUserList(usersString);
  }

  String _encodeUser(Map<String, dynamic> user) {
    return '${user['email']}|${user['password']}|${user['firstName']}|${user['lastName']}';
  }

  Map<String, dynamic> _decodeUser(String userString) {
    final parts = userString.split('|');
    return {
      'email': parts[0],
      'password': parts[1],
      'firstName': parts[2],
      'lastName': parts[3],
    };
  }

  String _encodeUserList(List<Map<String, dynamic>> users) {
    return users.map(_encodeUser).join(';');
  }

  List<Map<String, dynamic>> _decodeUserList(String usersString) {
    if (usersString.isEmpty) return [];
    return usersString.split(';').map(_decodeUser).toList();
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref);
});

final authStateProvider = StreamProvider<AuthState>((ref) async* {
  final authService = ref.read(authServiceProvider);

  yield AuthState.loading();

  try {
    final currentUser = await authService.getCurrentUser();
    if (currentUser != null) {
      yield AuthState.authenticated(currentUser);
    } else {
      yield AuthState.initial();
    }
  } catch (e) {
    yield AuthState.error(e.toString());
  }

  // Listen to auth changes
  yield* authService.authChanges.asyncMap((user) async {
    if (user != null) {
      return AuthState.authenticated(user);
    } else {
      return AuthState.initial();
    }
  });
});
Future<void> _checkCurrentUser(
    AuthService authService, StreamController<AuthState> controller) async {
  controller.add(AuthState.loading());
  try {
    final currentUser = await authService.getCurrentUser();
    if (currentUser != null) {
      controller.add(AuthState.authenticated(currentUser));
    } else {
      controller.add(AuthState.initial());
    }
  } catch (e) {
    controller.add(AuthState.error(e.toString()));
  }
}

class AuthStateNotifier {
  final Ref ref;

  AuthStateNotifier(this.ref);

  Future<void> login(String email, String password) async {
    try {
      final response = await ref.read(authServiceProvider).login(
            email: email,
            password: password,
          );
      // The stream will automatically update when SharedPreferences change
    } catch (e) {
      // Error will be caught by the stream when checking current user
      rethrow;
    }
  }

  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      await ref.read(authServiceProvider).signUp(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,
          );
      // After signup, automatically log the user in
      await login(email, password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await ref.read(authServiceProvider).logout();
    // The stream will automatically update to initial state
  }
}

final authStateNotifierProvider = Provider<AuthStateNotifier>((ref) {
  return AuthStateNotifier(ref);
});

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

final currentUserProvider = Provider<Map<String, dynamic>?>((ref) {
  final authState = ref.watch(authStateProvider).value;
  return authState?.isAuthenticated == true ? authState?.user : null;
});
