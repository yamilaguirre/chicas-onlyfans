import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Guard para proteger rutas que requieren autenticación
class AuthGuard extends RouteGuard {
  final String? requiredType;

  AuthGuard({this.requiredType}) : super(redirectTo: '/auth/sign-in');

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    // Verificar si hay un usuario autenticado
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return false;
    }

    // Permitir acceso a select-role para usuarios autenticados
    if (path.contains('/select-role')) {
      return true;
    }

    // Si se requiere un tipo específico, verificar
    if (requiredType != null) {
      try {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (!userDoc.exists) {
          return false;
        }

        final userData = userDoc.data()!;
        final userType = (userData['type'] ?? userData['userType']) as String?;

        // Si el tipo es indefinido, redirigir a select-role
        if (userType == null || userType == 'indefinido') {
          Modular.to.navigate('/auth/select-role');
          return false;
        }

        // Verificar si el tipo coincide con el requerido
        if (userType != requiredType) {
          // Redirigir al home correcto según su tipo
          final targetRoute = userType == 'female'
              ? '/female/contenido'
              : '/male/home';
          Modular.to.navigate(targetRoute);
          return false;
        }

        return true;
      } catch (e) {
        return false;
      }
    }

    return true;
  }
}
