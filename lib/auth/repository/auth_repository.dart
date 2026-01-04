import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseClient _client = Supabase.instance.client;

  // SIGN UP

  Future<void> signUpWithPassword({
    required String email,
    required String password,
    required String name,
    required String surname,
    required String address,
    required String phone,
  }) async {
    // Create auth user
    final authResponse = await _client.auth.signUp(
      email: email,
      password: password,
    );

    final user = authResponse.user;
    if (user == null) {
      throw Exception("Signup failed: user not created");
    }

    // Insert profile row
    final profileResponse = await _client.from('profiles').insert({
      'id': user.id,
      'name': name,
      'surname': surname,
      'address': address,
      'phone': phone,
    });
  }

  // SIGN IN

  Future<void> signInWithPassword({
    required String email,
    required String password,
  }) async {
    await _client.auth.signInWithPassword(email: email, password: password);
  }

  // SESSION HELPERS

  User? get currentUser => _client.auth.currentUser;

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final client = Supabase.instance.client;
    final user = client.auth.currentUser;

    if (user == null || user.email == null) {
      throw Exception("User not authenticated");
    }

    // Re-authenticate user (important)
    await client.auth.signInWithPassword(
      email: user.email!,
      password: currentPassword,
    );

    // Update password
    await client.auth.updateUser(UserAttributes(password: newPassword));
  }
}
