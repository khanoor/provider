import 'package:flutter/material.dart';
import 'package:provider_mvvm/utils/routes/routes_name.dart';
import 'package:provider_mvvm/view/home_screen.dart';
import 'package:provider_mvvm/view/login_screen.dart';
import 'package:provider_mvvm/view/signup_screen.dart';
import 'package:provider_mvvm/view/splash_screen.dart';

class Routes {
  static MaterialPageRoute generateRoutes(RouteSettings setting) {
    switch (setting.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());
      case RoutesName.signup:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignUpScreen());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text("No page found"),
            ),
          );
        });
    }
  }
}
