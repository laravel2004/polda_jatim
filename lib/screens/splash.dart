import 'package:flutter/material.dart';
import 'package:monitor/routes/route_name.dart';
import 'package:monitor/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    if (prefs.containsKey('host') && prefs.containsKey('token') && prefs.containsKey('serverId')) {
      Navigator.popAndPushNamed(context, RouteName.homeScreen);
      return;
    }
    else {
      Navigator.popAndPushNamed(context, RouteName.settingScreen);
    }
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
