import 'package:flutter_modular/flutter_modular.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/home/presentation/screens/favorites_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/chat/presentation/screens/chats_screen.dart';
import '../../features/chat/presentation/screens/chat_detail_screen.dart';
import '../../features/packages/presentation/screens/packages_screen.dart';
import '../../features/videocall/presentation/screens/videocall_screen.dart';

/// Módulo para usuarios hombres/suscriptores
class MaleModule extends Module {
  @override
  void binds(i) {
    // Bindings específicos para el módulo male
  }

  @override
  void routes(r) {
    // Pantalla principal home
    r.child(
      '/home',
      child: (context) => const HomeScreen(),
      transition: TransitionType.fadeIn,
    );

    // Pantalla de favoritos
    r.child('/favorites', child: (context) => const FavoritesScreen());

    // Pantalla de perfil
    r.child('/profile', child: (context) => const ProfileScreen());

    // Pantalla de chats
    r.child('/chats', child: (context) => const ChatsScreen());

    // Pantalla de detalle de chat
    r.child(
      '/chats/:chatId',
      child: (context) => ChatDetailScreen(
        name: r.args.data['name'] ?? 'Chat',
        avatar: r.args.data['avatar'] ?? '',
        isOnline: r.args.data['isOnline'] ?? false,
      ),
    );

    // Pantalla de paquetes/compra de minutos
    r.child('/packages', child: (context) => const PackagesScreen());

    // Pantalla de videollamada (comentado hasta implementar)
    // r.child(
    //   '/videocall/:creatorId',
    //   child: (context) => const VideocallScreen(),
    // );
  }
}
