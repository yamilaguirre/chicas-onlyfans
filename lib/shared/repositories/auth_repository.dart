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

  Future<bool> checkUserExists(String uid) async {
    return await _phoneAuthService.checkUserExists(uid);
  }

  Future<void> updateUserProfile({
    required String userId,
    required String name,
    required String username,
    required DateTime birthDate,
    String? email,
    String? photoUrl,
  }) async {
    await _phoneAuthService.updateUserProfile(
      userId: userId,
      name: name,
      username: username,
      birthDate: birthDate,
      email: email,
      photoUrl: photoUrl,
    );
  }

  Future<void> signOut() async {
    await _phoneAuthService.signOut();
  }
}
