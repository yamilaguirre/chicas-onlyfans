import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/user.dart';
import 'auth_state.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  AuthState build() {
    return const AuthState.initial();
  }

  Future<void> loginWithPhone(String phone, String password) async {
    state = const AuthState.loading();
    
    try {
      // Simulación de login - aquí iría la lógica real
      await Future.delayed(const Duration(seconds: 2));
      
      // Usuario de prueba
      if (phone == "123456789" && password == "123456") {
        final user = User(
          id: "1",
          name: "Usuario Test",
          phone: phone,
          email: "test@example.com",
          birthDate: DateTime(1990, 1, 1),
          isVerified: true,
        );
        
        state = AuthState.authenticated(user);
      } else {
        state = const AuthState.error("Credenciales incorrectas");
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> register({
    required String name,
    required String phone,
    required DateTime birthDate,
    String? email,
  }) async {
    state = const AuthState.loading();
    
    try {
      await Future.delayed(const Duration(seconds: 2));
      
      final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        phone: phone,
        email: email,
        birthDate: birthDate,
        isVerified: false,
      );
      
      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  void logout() {
    state = const AuthState.unauthenticated();
  }
}