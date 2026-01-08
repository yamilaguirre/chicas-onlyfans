import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:chicas_app/features/auth/presentation/screens/woman/donadores_screen.dart';
import 'package:chicas_app/features/auth/presentation/screens/woman/salaFinalizada.dart';
import 'package:chicas_app/features/auth/presentation/screens/woman/contenido_screen.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  late CameraController _controller;
  bool camaraLista = false;

  int botonSeleccionado = -1;

  // ===== NUEVAS VARIABLES =====
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<Map<String, String>> mensajes = [
    {
      "img": "assets/user1.jpg",
      "nombre": "Mario Castro",
      "mensaje": "Hola a todos 👋",
    },
    {
      "img": "assets/user2.jpg",
      "nombre": "Sofía Ramirez",
      "mensaje": "Bienvenidos al Live!",
    },
    {
      "img": "assets/user3.jpg",
      "nombre": "Laura Torres",
      "mensaje": "Qué bonita cámara 😍",
    },
  ];

  Timer? _timer;
  int _contadorMensajes = 30;

  @override
  void initState() {
    super.initState();
    iniciarCamara();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      iniciarMensajesAutomaticos();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    try {
      if (camaraLista && _controller.value.isInitialized) {
        _controller.dispose();
      }
    } catch (e) {
      // si el controlador no fue inicializado, ignorar
    }
    super.dispose();
  }

  // ===== INICIAR CAMARA =====
  Future<void> iniciarCamara() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        if (mounted) {
          setState(() => camaraLista = false);
        }
        return;
      }

      final camaraTrasera = cameras.first;

      _controller = CameraController(
        camaraTrasera,
        ResolutionPreset.high,
        enableAudio: true,
      );

      await _controller.initialize();

      if (mounted) {
        setState(() {
          camaraLista = _controller.value.isInitialized;
        });
      }
    } on CameraException catch (e) {
      debugPrint('CameraException iniciarCamara: $e');
      if (mounted) setState(() => camaraLista = false);
    } catch (e) {
      debugPrint('Error iniciarCamara: $e');
      if (mounted) setState(() => camaraLista = false);
    }
  }

  // ===== MENSAJES AUTOMÁTICOS CON ANIMACIÓN =====
  void iniciarMensajesAutomaticos() {
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      _contadorMensajes++;
      Map<String, String> nuevo = {
        "img": "assets/user${(_contadorMensajes % 5) + 1}.jpg",
        "nombre": "Usuario $_contadorMensajes",
        "mensaje": "Mensaje automático $_contadorMensajes ✨",
      };
      mensajes.insert(0, nuevo);
      _listKey.currentState?.insertItem(
        0,
        duration: const Duration(milliseconds: 50),
      );

      // Limitar lista a 20 mensajes
      if (mensajes.length > 20) {
        mensajes.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ===== FONDO DE CÁMARA =====
          Positioned.fill(
            child: camaraLista
                ? CameraPreview(_controller)
                : Container(color: Colors.black),
          ),

          // ===== BARRA SUPERIOR =====
          Positioned(
            top: 40,
            left: 15,
            right: 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // --- BURBUJA IZQUIERDA ---
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                      255,
                      20,
                      20,
                      20,
                    ).withOpacity(0.50),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Colors.pinkAccent, Colors.orange],
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 22,
                          backgroundImage: AssetImage("assets/model.jpg"),
                        ),
                      ),
                      const SizedBox(width: 10),

                      // --- TEXTO IZQUIERDO ---
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "@maria_gz",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Sala 4/6",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // --- AVATARES DERECHA ---
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RankingDonadores(),
                          ),
                        );
                      },
                      child: _miniViewer(
                        "assets/view1.jpg",
                        Colors.yellow,
                        "1",
                      ),
                    ),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RankingDonadores(),
                          ),
                        );
                      },
                      child: _miniViewer(
                        "assets/view2.jpg",
                        Colors.purple,
                        "2",
                      ),
                    ),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RankingDonadores(),
                          ),
                        );
                      },
                      child: _miniViewer(
                        "assets/view3.jpg",
                        Colors.orange,
                        "3",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ===== AVATARES IZQUIERDA =====
          Positioned(
            top: 120,
            left: 10,
            child: Column(
              children: [
                _avatar("assets/profile1.png"),
                const SizedBox(height: 10),
                _avatar("assets/a2.png"),
                const SizedBox(height: 10),
                _avatar("assets/a3.png"),
                const SizedBox(height: 10),
                _avatar("assets/a4.png"),
                const SizedBox(height: 20),

                // Botón "+"
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.20),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 28),
                ),
              ],
            ),
          ),

          // ===== BOTONES DERECHA =====
          Positioned(
            right: 10,
            bottom: 200,
            child: Column(
              children: [
                _rightBtn(Icons.flip_camera_android, "Voltear", 0),
                const SizedBox(height: 22),
                _rightBtn(Icons.filter_alt_rounded, "Filtros", 1),
                const SizedBox(height: 22),
                _rightBtn(Icons.auto_fix_high, "Efectos", 2),
                const SizedBox(height: 22),
                _rightBtn(Icons.people_alt, "Doble", 3),
                const SizedBox(height: 22),
                _rightBtn(Icons.text_fields, "Texto", 4),
              ],
            ),
          ),

          // ===== LISTA DE COMENTARIOS =====
          Positioned(
            left: 10,
            bottom: 120,
            width: 260,
            height: 240,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.white],
                  stops: [0.0, 0.15],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: AnimatedList(
                key: _listKey,
                reverse: true,
                padding: const EdgeInsets.only(bottom: 20),
                initialItemCount: mensajes.length,
                itemBuilder: (context, index, animation) {
                  final item = mensajes[index];
                  return SizeTransition(
                    sizeFactor: animation,
                    axisAlignment: 0.0,
                    child: _chatItem(
                      img: item["img"]!,
                      nombre: item["nombre"]!,
                      online: false,
                      mensaje: item["mensaje"]!,
                    ),
                  );
                },
              ),
            ),
          ),

          // ===== INPUT DE COMENTARIO =====
          Positioned(
            left: 10,
            right: 10,
            bottom: 70,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 45,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                        255,
                        58,
                        57,
                        57,
                      ).withOpacity(0.20),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Escribe un comentario...",
                        hintStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.pinkAccent, Colors.orange],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.send, color: Colors.white, size: 22),
                ),
              ],
            ),
          ),

          // ===== BOTÓN FINALIZAR =====
          Positioned(
            bottom: 8,
            right: 12,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CrearContenidoPage(),
                  ), //o salaFinalizada
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 84, 21, 89),
                      Color.fromARGB(255, 249, 101, 177),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Text(
                  "Finalizar Sala",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ), //termina boton finalizar
        ],
      ),
    );
  }

  // ================== Widgets ==================

  Widget _avatar(String img) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
      ),
    );
  }

  // Función única de botones derechos
  Widget _rightBtn(IconData icon, String text, int index) {
    bool activo = botonSeleccionado == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          botonSeleccionado = index;
        });
      },
      child: Column(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: activo
                  ? Colors.pinkAccent
                  : Colors.white.withOpacity(0.20),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 5),
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _chatItem({
    required String img,
    required String nombre,
    required bool online,
    required String mensaje,
    bool vip = false,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.18),
              width: 1.2,
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(radius: 16, backgroundImage: AssetImage(img)),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nombre,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      mensaje,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _miniViewer(String img, Color color, String number) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 3),
          ),
          child: CircleAvatar(radius: 18, backgroundImage: AssetImage(img)),
        ),
        Positioned(
          right: -2,
          bottom: -2,
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
