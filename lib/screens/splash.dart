import 'package:flutter/material.dart';
import 'home_page.dart';
import '../utils/app_colors.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller; // Controls animation timing
  late Animation<double> _animation;    // Controls opacity

  @override
  void initState() {
    super.initState();

    // Animation controller (fade-in effect)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Opacity animation from 0 → 1
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Start animation
    _controller.forward();

    // Navigate to HomePage after delay
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Free memory
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary, // Blue background

      body: FadeTransition(
        opacity: _animation,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.directions_bus,
                size: 80,
                color: Colors.white,
              ),
              SizedBox(height: 20),
              Text(
                'BusMate',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Book your seats instantly',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
