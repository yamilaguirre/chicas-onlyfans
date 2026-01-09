import 'package:flutter/material.dart';
import 'package:chicas_app/features/auth/presentation/screens/woman/contn_screen.dart';
import 'package:chicas_app/features/auth/presentation/screens/woman/chat_screen.dart';
import 'package:chicas_app/features/auth/presentation/screens/woman/live_page.dart';
import 'package:chicas_app/features/auth/presentation/screens/woman/sala_Screen.dart';
import 'package:chicas_app/features/auth/presentation/screens/woman/live2_page.dart';
import 'package:chicas_app/features/auth/presentation/screens/woman/live3_pague.dart';
import 'package:chicas_app/features/auth/presentation/screens/woman/camera_page.dart';

class CrearContenidoPage extends StatelessWidget {
  const CrearContenidoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7e9f5),
      bottomNavigationBar: _bottomNavBar(context, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Crear Contenido",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff4c3a57),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "¿Qué deseas crear?",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff4c3a57),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Elige una opción para comenzar",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),

              const SizedBox(height: 40),

              // FILA SUPERIOR
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _opcionCard(
                    colores: [Colors.redAccent, Colors.pinkAccent],
                    icon: Icons.wifi_tethering,
                    titulo: "Iniciar\nLive",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CameraPage()),
                      );
                    },
                  ),

                  // OPCIÓN 3
                  _opcionCard(
                    colores: [Color(0xff3d0647), Color(0xffb56bd8)],
                    icon: Icons.groups_2_outlined,
                    titulo: "Crear\nSala 7-9",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SalaScreen()),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // OPCIÓN INFERIOR
              Align(
                alignment: Alignment.centerLeft,
                child: _opcionCard(
                  colores: [Color(0xffe774ff), Color(0xffff8ab9)],
                  icon: Icons.upload_rounded,
                  titulo: "Subir\ncontenido",
                  width: 150,
                  onTap: () {
                    // Acción al subir contenido
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ConfiguracionLive2Page(),
                      ),
                    );
                  },
                ),
              ),
              //2
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- TARJETA DE OPCIÓN --------------------
  Widget _opcionCard({
    required List<Color> colores,
    required IconData icon,
    required String titulo,
    double width = 150,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 150,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          gradient: LinearGradient(
            colors: colores,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withValues(alpha: 0.2),
              blurRadius: 15,
              offset: const Offset(3, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white, size: 38),
            const SizedBox(height: 15),
            Text(
              titulo,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //------------botones nav bar contenido screen----------
  Widget _bottomNavBar(BuildContext context, int currentIndex) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: const Color(0xff4c2050),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white60,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (index) {
        if (index == currentIndex) return;
        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ContnScreen()),
            );
            break;
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const CrearContenidoPage()),
            );
            break;
          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ChatPage()),
            );
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "perfil"),
        BottomNavigationBarItem(icon: Icon(Icons.star), label: "crear"),
        BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: "chat"),
      ],
    );
  }
}
