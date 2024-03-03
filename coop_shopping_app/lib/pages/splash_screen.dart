import 'package:coop_shopping_app/pallete.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({super.key, this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => widget.child!),
            (route) => false);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Pallete.gradient1,
      body: Center(
        child: Text(
          'Accra Buyers Club',
          style: TextStyle(
            color: Pallete.backgroundColor,
            fontWeight: FontWeight.bold,
            fontSize: 40,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(3.0, 5.0),
                blurRadius: 3.0,
                color: Pallete.gradient2,
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
