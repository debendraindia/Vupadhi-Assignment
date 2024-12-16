import 'package:flutter/material.dart';
import 'package:vupadhi/app/routes/route_names.dart';
import 'package:vupadhi/views/dynamic_form/dynamic_form_screen.dart';
import 'package:vupadhi/views/home/home_screen.dart';
import 'package:vupadhi/views/login/login_screen.dart';
import 'package:vupadhi/views/splash/splash_screen.dart';

class AppRoutes {
  /// Route builder for this application
  /// All routes are defined here
  static Map<String, WidgetBuilder> appRoutes = {
    RouteNames.splashScreen: (context) => SplashScreen(),
    RouteNames.loginScreen: (context) => LoginScreen(),
    RouteNames.homeScreen: (context) => HomeScreen(),
  };
}
