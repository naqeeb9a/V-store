import 'package:flutter/material.dart';
import 'package:store/Screens/IntroScreens/intro.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Alignment _alignment = Alignment.topCenter;
  final Duration _duration = const Duration(seconds: 2);

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1)).then(
      (value) => setState(() {
        _alignment = Alignment.center;
      }),
    );
    Future.delayed(_duration * 1.2).then(
      (value) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const OnBoardingPage(),
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        alignment: _alignment,
        duration: _duration,
        child: Image.asset(
          'assets/logo.jpeg',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
