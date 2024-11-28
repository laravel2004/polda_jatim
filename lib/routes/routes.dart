import 'package:flutter/material.dart';
import 'package:monitor/routes/route_name.dart';
import 'package:monitor/screens/dashboard.dart';
import 'package:monitor/screens/splash.dart';
import 'package:monitor/screens/template/app_template.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.homeScreen :
        return MaterialPageRoute(builder: (_) => const AppTemplate(initialIndex: 0));
      case RouteName.settingScreen :
        return MaterialPageRoute(builder: (_) => const AppTemplate(initialIndex: 2));
      case RouteName.splashScreen :
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      default:
        return MaterialPageRoute(builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ));
    }
  }
}