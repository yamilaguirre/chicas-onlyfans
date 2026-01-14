import 'package:flutter_modular/flutter_modular.dart';
import '../../features/auth/presentation/screens/woman/contenido_screen.dart';
// import '../../features/auth/presentation/screens/woman/donadores_screen.dart';
// import '../../features/auth/presentation/screens/woman/chat_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';

/// Módulo para creadoras de contenido/mujeres
class FemaleModule extends Module {
  @override
  void binds(i) {
    // Bindings específicos para el módulo female
  }

  @override
  void routes(r) {
    // Pantalla principal de crear contenido
    r.child(
      '/contenido',
      child: (context) => const CrearContenidoPage(),
      transition: TransitionType.fadeIn,
    );

    // Pantalla de donadores/top donadores (comentado hasta implementar)
    // r.child('/donadores', child: (context) => const DonadoresScreen());

    // Pantalla de chat para creadoras (comentado hasta implementar)
    // r.child('/chat', child: (context) => const ChatScreenWoman());

    // Pantalla de perfil (compartida)
    r.child('/profile', child: (context) => const ProfileScreen());
  }
}
