import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/loading/data/datasources/loading_tips.dart';
import 'package:lumina_frontend/routes.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;
  final List<String> images = [];
  String _currentTip = "";
  final Random _random = Random();
  Timer? _tipTimer;

  @override
  void initState() {
    super.initState();

    // Load images
    for (int i = 1; i <= 5; i++) {
      images.add('assets/images/loading_progress/loading_$i.png');
    }

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5), // 5 images, 1 second each
    )..repeat();

    _animation = IntTween(begin: 0, end: images.length - 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    
    int cycles = 1;
    _tipTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (cycles == 5) {
        timer.cancel();
        Navigator.pushReplacementNamed(context, Routes.landing);
      }
      if (mounted) {
        setState(() {
          cycles++;
          _currentTip =
              LoadingTips.tips[_random.nextInt(LoadingTips.tips.length)];
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (String imagePath in images) {
        precacheImage(AssetImage(imagePath), context);
      }
    });

    // Set the first tip
    _currentTip = LoadingTips.tips[_random.nextInt(LoadingTips.tips.length)];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainTheme.luminaBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              images[_animation.value],
              width: 300,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Container(
                width: MediaQuery.of(context).size.width *
                    0.8, // 80% of screen width
                child: Text(
                  _currentTip,
                  style: MainTheme.h3White,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
