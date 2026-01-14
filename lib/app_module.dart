import 'package:flutter_modular/flutter_modular.dart';
import 'core/modules/auth_module.dart';
import 'core/modules/male_module.dart';
import 'core/modules/female_module.dart';
import 'main.dart';

/// Módulo principal de la aplicación
class AppModule extends Module {
  @override
  void binds(i) {
    // Aquí van los bindings globales (servicios singleton, repositorios, etc.)
  }

  @override
  void routes(r) {
    // Ruta inicial - AuthWrapper verifica autenticación
    r.child('/', child: (context) => const AuthWrapper());

    // Módulo de autenticación
    r.module('/auth', module: AuthModule());

    // Módulo para usuarios hombres/suscriptores
    r.module('/male', module: MaleModule());

    // Módulo para creadoras/mujeres
    r.module('/female', module: FemaleModule());
  }
}
