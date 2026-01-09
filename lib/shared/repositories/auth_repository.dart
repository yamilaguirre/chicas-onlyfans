import 'package:firebase_auth/firebase_auth.dart';
import '../services/phone_auth_service.dart';

class AuthRepository {
  final PhoneAuthService _phoneAuthService;

  AuthRepository(this._phoneAuthService);

  Future<String> sendPhoneOTP(String phoneNumber) async {
    return await _phoneAuthService.sendOTP(phoneNumber);
  }

  Future<User?> verifyPhoneOTP({
    required String verificationId,
    required String otp,
    required String phoneNumber,
  }) async {
    return await _phoneAuthService.verifyOTP(
      verificationId: verificationId,
      otp: otp,
      phoneNumber: phoneNumber,
    );
  }

  User? getCurrentUser() {
    return _phoneAuthService.getCurrentUser();
  }

  Future<void> signOut() async {
    await _phoneAuthService.signOut();
  }
}
