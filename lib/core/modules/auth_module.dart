import 'package:flutter_modular/flutter_modular.dart';
import '../../features/auth/presentation/screens/sign_in_screen.dart';
import '../../features/auth/presentation/screens/phone_number_screen.dart';
import '../../features/auth/presentation/screens/verification_code_screen.dart';
import '../../features/auth/presentation/screens/name_screen.dart';
import '../../features/auth/presentation/screens/birth_date_screen.dart';
import '../../features/auth/presentation/screens/profile_confirmation_screen.dart';
import '../../features/auth/presentation/screens/follow_profiles_screen.dart';
import '../../features/auth/presentation/screens/role_selection_screen.dart';
import '../../shared/repositories/auth_repository.dart';
import '../../shared/services/phone_auth_service.dart';
import '../enums/user_type.dart';

/// Módulo de autenticación
class AuthModule extends Module {
  @override
  void binds(i) {
    // Servicios de autenticación
    i.addSingleton(PhoneAuthService.new);
    i.addSingleton(AuthRepository.new);
    // Controllers ya están con Riverpod, no necesitan binding aquí
  }

  @override
  void routes(r) {
    // Pantalla de inicio de sesión
    r.child('/sign-in', child: (context) => const SignInScreen());

    // Pantalla de selección de rol/tipo de usuario
    r.child('/select-role', child: (context) => const RoleSelectionScreen());

    // Pantalla de ingreso de número telefónico
    r.child(
      '/phone',
      child: (context) => PhoneNumberScreen(
        userType: r.args.data['userType'] ?? UserType.male,
        isLogin: r.args.data['isLogin'] ?? false,
      ),
    );

    // Pantalla de verificación de código OTP
    r.child(
      '/verification',
      child: (context) => VerificationCodeScreen(
        phoneNumber: r.args.data['phoneNumber'],
        verificationId: r.args.data['verificationId'],
        userType: r.args.data['userType'],
        isLogin: r.args.data['isLogin'] ?? false,
      ),
    );

    // Pantalla de registro de nombre
    r.child(
      '/name',
      child: (context) => NameScreen(
        phoneNumber: r.args.data['phoneNumber'],
        userType: r.args.data['userType'],
      ),
    );

    // Pantalla de fecha de nacimiento
    r.child(
      '/birthdate',
      child: (context) => BirthDateScreen(
        phoneNumber: r.args.data['phoneNumber'],
        name: r.args.data['name'],
        userType: r.args.data['userType'],
      ),
    );

    // Pantalla de confirmación de perfil
    r.child(
      '/profile-confirmation',
      child: (context) => ProfileConfirmationScreen(
        phoneNumber: r.args.data['phoneNumber'],
        name: r.args.data['name'],
        birthDate: r.args.data['birthDate'],
        userType: r.args.data['userType'],
      ),
    );

    // Pantalla de seguir perfiles
    r.child(
      '/follow-profiles',
      child: (context) => FollowProfilesScreen(
        phoneNumber: r.args.data['phoneNumber'],
        name: r.args.data['name'],
        username: r.args.data['username'],
        birthDate: r.args.data['birthDate'],
        email: r.args.data['email'],
        userType: r.args.data['userType'],
      ),
    );
  }
}
