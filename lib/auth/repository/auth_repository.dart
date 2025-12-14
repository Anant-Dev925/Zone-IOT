import 'package:iot/auth/services/resend_otp_service.dart';

class AuthRepository {
  final ResendOtpService resendService = ResendOtpService();

  /// SIGN UP
  Future<(bool, String, dynamic)> signUp(
    String name,
    String surname,
    String address,
    String email,
    String phone,
  ) async {
    try {
      // TODO: Call actual signup endpoint
      // final response = await resendService.sendOtp(email, phone);

      return (true, "OTP sent", null);
    } catch (e) {
      return (false, e.toString(), null);
    }
  }

  /// SIGN IN
  Future<(bool, String, dynamic)> signIn(String email, String phone) async {
    try {
      // TODO: Call signin OTP endpoint

      return (true, "OTP sent", null);
    } catch (e) {
      return (false, e.toString(), null);
    }
  }

  /// VERIFY OTP
  Future<(bool, String, dynamic)> verifyOtp(
    String email,
    String phone,
    String otp,
  ) async {
    try {
      // TODO: Call verify OTP endpoint, return user

      return (true, "Verified", {"name": "Demo User"});
    } catch (e) {
      return (false, e.toString(), null);
    }
  }
}
