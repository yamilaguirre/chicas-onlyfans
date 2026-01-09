import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/user.dart';
import '../../../../shared/repositories/auth_repository.dart';
import '../../../../shared/services/phone_auth_service.dart';
import 'auth_state.dart';

part 'auth_controller.g.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(PhoneAuthService());
});

@riverpod
class AuthController extends _$AuthController {
  late AuthRepository _authRepository;

  @override
  AuthState build() {
    _authRepository = ref.watch(authRepositoryProvider);
    return const AuthState.initial();
  }

  Future<String> sendPhoneOTP(String phoneNumber) async {
    state = const AuthState.loading();
    try {
      final phoneWithCode = phoneNumber.startsWith('+')
          ? phoneNumber
          : '+591$phoneNumber';
      final verificationId = await _authRepository.sendPhoneOTP(phoneWithCode);
      state = const AuthState.initial();
      return verificationId;
    } catch (e) {
      state = AuthState.error(e.toString());
      rethrow;
    }
  }

  Future<void> verifyPhoneOTP({
    required String verificationId,
    required String otp,
    required String phoneNumber,
  }) async {
    state = const AuthState.loading();
    try {
      final phoneWithCode = phoneNumber.startsWith('+')
          ? phoneNumber
          : '+591$phoneNumber';

      final firebaseUser = await _authRepository.verifyPhoneOTP(
        verificationId: verificationId,
        otp: otp,
        phoneNumber: phoneWithCode,
      );

      if (firebaseUser != null) {
        final user = User(
          id: firebaseUser.uid,
          name: firebaseUser.displayName ?? 'Usuario',
          phone: phoneWithCode,
          email: firebaseUser.email,
          birthDate: DateTime.now(),
          isVerified: firebaseUser.emailVerified,
        );
        state = AuthState.authenticated(user);
      } else {
        state = const AuthState.error('Error en autenticación');
      }
    } catch (e) {
      state = AuthState.error(e.toString());
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _authRepository.signOut();
      state = const AuthState.unauthenticated();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }
}
