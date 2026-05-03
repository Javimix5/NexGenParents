import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'home/home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with WidgetsBindingObserver {
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;
  bool _navigated = false; // Evita que se navegue más de una vez

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Registrar el observador del ciclo de vida
    _initVideoAndAudio();
  }

  Future<void> _initVideoAndAudio() async {
    // 1. Leer de SharedPreferences si es la primera vez que se abre la app
    final prefs = await SharedPreferences.getInstance();
    final bool isFirstTime = prefs.getBool('is_first_time_welcome') ?? true;

    // Si no es la primera vez, saltamos el vídeo y vamos al Home directamente
    if (!isFirstTime) {
      _navigateToHome();
      return;
    }

    // 2. Configurar el controlador del vídeo
    _videoController = VideoPlayerController.asset('assets/video/introNgP.mp4');

    try {
      await _videoController!.initialize();
      
      // 3. Configuramos volumen y marcamos para que la próxima vez se salte
      // En la web, los navegadores bloquean el autoplay si el vídeo tiene sonido.
      await _videoController!.setVolume(kIsWeb ? 0.0 : 1.0);
      await prefs.setBool('is_first_time_welcome', false);

      setState(() {
        _isVideoInitialized = true;
      });

      // 4. Escuchar el progreso del vídeo para saber cuándo termina
      _videoController!.addListener(_videoListener);
      
      await _videoController!.play();
    } catch (e) {
      debugPrint('Error al cargar el vídeo: $e');
      _navigateToHome(); // Fallback en caso de que no cargue el vídeo
    }
  }

  // Este método comprueba si el vídeo ha llegado al final
  void _videoListener() {
    if (_videoController?.value.isInitialized ?? false) {
      if (_videoController!.value.position >= _videoController!.value.duration) {
        _videoController!.removeListener(_videoListener);
        _navigateToHome();
      }
    }
  }

  // Detecta cuando la app se minimiza o se restaura
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (!_isVideoInitialized || _videoController == null) return;

    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      _videoController!.pause(); // Pausa el vídeo (y el audio) si se minimiza
    } else if (state == AppLifecycleState.resumed) {
      _videoController!.play(); // Reanuda si vuelve a la app
    }
  }

  void _navigateToHome() {
    if (_navigated || !mounted) return;
    _navigated = true;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800), // Duración del fundido
        pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Importante limpiar el observador
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fondo negro para evitar franjas claras
      body: Center(
        child: _isVideoInitialized && _videoController != null
            ? GestureDetector(
                onTap: _navigateToHome, // Permite saltar la intro al tocar la pantalla
                child: AspectRatio(
                  aspectRatio: _videoController!.value.aspectRatio,
                  child: VideoPlayer(_videoController!),
                ),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}