import 'package:flutter/material.dart';
import 'package:monitor/routes/route_name.dart';
import 'package:monitor/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    navigateToNextScreen();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.popAndPushNamed(context, RouteName.homeScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.primary,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Image.asset('assets/images/polda_jatim.png', width: 50),
                const SizedBox(width: 10),
                Image.asset('assets/images/tik_polda.png', width: 50),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 20),
            Image.asset('assets/images/logo.png', width: 400),
            const Center(
              child: Text(
                  textAlign: TextAlign.center,
                  'Server Monitoring\n Polda Jatim Bidang TIK',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )
              ),
            ),
            const SizedBox(height: 20),
          ],
        )
      ),
    );
  }
}
