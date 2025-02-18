import 'dart:async';
import 'dart:math'; 
import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/loading/data/datasources/loading_tips.dart';
import 'package:lumina_frontend/routes.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  Timer? _timer;
  int _currentImageIndex = 1;
  String _currentTip = "";
  final Random _random = Random();
  bool _imageLoaded = false;

  @override
  void initState() {
    super.initState();
    // Set the initial tip if needed (it won't be shown until the image loads)
    _currentTip = LoadingTips.tips[_random.nextInt(LoadingTips.tips.length)];
    int cycles = 1;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (cycles == 5) {
        timer.cancel();
        Navigator.pushReplacementNamed(context, Routes.landing);
      } else {
        cycles++;
        setState(() {
          _currentImageIndex = cycles;
          _imageLoaded = false; // Reset until new image is loaded
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
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
              'assets/images/loading_progress/loading_$_currentImageIndex.png',
              // frameBuilder ensures the image is loaded before updating the tip text.
              frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                if (frame != null && !_imageLoaded) {
                  // Once the image loads, update _imageLoaded and then show the tip.
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      _imageLoaded = true;
                      _currentTip = LoadingTips.tips[_random.nextInt(LoadingTips.tips.length)];
                    });
                  });
                }
                return child;
              },
            ),
            // Only show the tip once the image has loaded.
            if (_imageLoaded)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(_currentTip, style: MainTheme.h3White,),
              ),
          ],
        ),
      ),
    );
  }
}