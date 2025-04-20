import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:tsalul_url_player/core/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // late AnimationController _controller;
  // late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // _controller = AnimationController(
    //   duration: const Duration(seconds: 2),
    //   vsync: this,
    // );

    // _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    // _controller.forward();
    // _animation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     Navigator.pushReplacementNamed(context, '/home');
    //   }
    // });
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.yellowGradient),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated image
              // ScaleTransition(
              //   scale: _animation,
              //   child: Icon(Icons.play_circle_outlined, size: 120),
              // ),
              // const SizedBox(height: 20),
              // Typing animation with color change
              AnimatedTextKit(
                onFinished: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Tsalul URL Player',
                    textStyle: AppTheme.headlineStyle,
                    speed: const Duration(milliseconds: 100),
                    textAlign: TextAlign.center,
                  ),
                ],
                totalRepeatCount: 1,
                displayFullTextOnTap: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
