import 'package:supabase_flutter/supabase_flutter.dart';

class DeviceRepository {
  final SupabaseClient _client = Supabase.instance.client;

  // Internal helper
  String get _userId {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }
    return user.id;
  }

  // FETCH ALL DEVICES
  Future<List<Map<String, dynamic>>> getDevices() async {
    final data = await _client
        .from('devices')
        .select()
        .eq('user_id', _userId)
        .order('created_at', ascending: true);

    return List<Map<String, dynamic>>.from(data);
  }

  // FETCH SINGLE DEVICE
  Future<Map<String, dynamic>> getDeviceById(String deviceId) async {
    final data = await _client
        .from('devices')
        .select()
        .eq('id', deviceId)
        .eq('user_id', _userId)
        .single();

    return data;
  }

  // ADD DEVICE
  Future<void> addDevice({
    required String deviceUid,
    required String deviceName,
    required int levelPercent,
  }) async {
    await _client.from('devices').insert({
      'user_id': _userId,
      'device_uid': deviceUid,
      'device_name': deviceName,
      'level_percent': levelPercent,
    });
  }

  // UPDATE DEVICE (NO UID HERE )
  Future<void> updateDevice({
    required String deviceId,
    required String deviceName,
    required int reorderLevel,
    required int reorderQuantity,
    required String medicineName,
    required String pincode,
    required String zone,
    required String address,
  }) async {
    await _client
        .from('devices')
        .update({
          'device_name': deviceName,
          'reorder_level': reorderLevel,
          'reorder_quantity': reorderQuantity,
          'medicine_name': medicineName,
          'delivery_pincode': pincode,
          'delivery_zone': zone,
          'delivery_address': address,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', deviceId)
        .eq('user_id', _userId);
  }

  // UPDATE LEVEL
  Future<void> updateLevel({
    required String deviceId,
    required int levelPercent,
  }) async {
    await _client
        .from('devices')
        .update({
          'level_percent': levelPercent,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', deviceId)
        .eq('user_id', _userId);
  }

  // DELETE DEVICE
  Future<void> deleteDevice(String deviceId) async {
    await _client
        .from('devices')
        .delete()
        .eq('id', deviceId)
        .eq('user_id', _userId);
  }
}
