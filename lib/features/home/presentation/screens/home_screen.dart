import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'favorites_screen.dart';
import '../../../packages/presentation/screens/packages_screen.dart';
import '../../../chat/presentation/screens/chats_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;
  int _currentProfileIndex = 0;

  // Lista de perfiles de ejemplo
  final List<Map<String, dynamic>> _profiles = [
    {
      'name': 'Carla',
      'age': 25,
      'distance': '18:32',
      'description':
          'Monday is closer and I dont want to get angry. Just get happy 🎉',
      'image': 'assets/images/profiles/chica1.jpg',
    },
    {
      'name': 'María',
      'age': 23,
      'distance': '15:20',
      'description': 'Love traveling and meeting new people ✈️',
      'image': 'assets/images/profiles/chica2.jpg',
    },
    {
      'name': 'Sofia',
      'age': 28,
      'distance': '20:45',
      'description': 'Coffee lover ☕ and photography enthusiast 📸',
      'image': 'assets/images/profiles/chica3.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _nextProfile() {
    setState(() {
      if (_currentProfileIndex < _profiles.length - 1) {
        _currentProfileIndex++;
      } else {
        _currentProfileIndex = 0;
      }
    });
  }

  void _likeProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('¡Te gusta este perfil! 💜'),
        duration: Duration(seconds: 1),
        backgroundColor: AppColors.primary,
      ),
    );
    _nextProfile();
  }

  @override
  Widget build(BuildContext context) {
    final currentProfile = _profiles[_currentProfileIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Imagen de fondo del perfil
          Positioned.fill(
            child: Image.network(
              currentProfile['image'],
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[800],
                  child: const Icon(
                    Icons.person,
                    size: 100,
                    color: Colors.white54,
                  ),
                );
              },
            ),
          ),

          // Gradiente oscuro en la parte inferior
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          // Contenido superior
          SafeArea(
            child: Column(
              children: [
                // Tabs superiores
                Container(
                  color: AppColors.primary,
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.white,
                    indicatorWeight: 3,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white70,
                    labelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    tabs: const [
                      Tab(text: 'Siguiendo'),
                      Tab(text: 'Para Ti'),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Indicador de tiempo/distancia
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        currentProfile['distance'],
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Información del perfil en la parte inferior
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    20,
                    20,
                    120,
                  ), // Más espacio abajo
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nombre y edad
                      Row(
                        children: [
                          Text(
                            currentProfile['name'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            currentProfile['age'].toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Descripción
                      Text(
                        currentProfile['description'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Botones de acción en el lado derecho
          Positioned(
            right: 12,
            bottom: 200,
            child: Column(
              children: [
                _buildActionButton(
                  icon: Icons.share,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Compartir perfil')),
                    );
                  },
                ),
                const SizedBox(height: 20),
                _buildActionButton(
                  icon: Icons.favorite_border,
                  onTap: _likeProfile,
                ),
                const SizedBox(height: 20),
                _buildActionButton(
                  icon: Icons.star_border,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Agregar a favoritos')),
                    );
                  },
                ),
              ],
            ),
          ),

          // Barra de navegación inferior
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavButton(Icons.add_circle_outline, 0),
                      _buildNavButton(Icons.grid_view, 1),
                      _buildNavButton(Icons.store, 2), // Cambiado a tienda
                      _buildNavButton(Icons.chat_bubble_outline, 3),
                      _buildNavButton(Icons.person_outline, 4),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Icon(icon, color: AppColors.primary, size: 26),
      ),
    );
  }

  Widget _buildNavButton(IconData icon, int index) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        // Solo cambiar el índice si es el botón de home (index 0)
        if (index == 0) {
          setState(() {
            _currentIndex = 0;
          });
          return;
        }

        // Para los demás botones, navegar a la pantalla correspondiente
        late final Widget destination;

        switch (index) {
          case 1:
            destination = const FavoritesScreen();
            break;
          case 2:
            destination = const PackagesScreen();
            break;
          case 3:
            destination = const ChatsScreen();
            break;
          case 4:
            destination = const ProfileScreen();
            break;
          default:
            return;
        }

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        ).then((_) {
          // Cuando regresa, resetear al home
          setState(() {
            _currentIndex = 0;
          });
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withOpacity(0.2)
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 28),
      ),
    );
  }
}
