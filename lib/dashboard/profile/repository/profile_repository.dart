import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<void> updateProfile({
    required String name,
    required String surname,
    required String address,
    required String phone,
  }) async {
    final user = _client.auth.currentUser;

    if (user == null) {
      throw Exception("User not authenticated");
    }

    final response = await _client
        .from('profiles')
        .update({
          'name': name,
          'surname': surname,
          'address': address,
          'phone': phone,
        })
        .eq('id', user.id);
  }
}
