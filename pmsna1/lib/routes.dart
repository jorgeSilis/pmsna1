import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/Login_screen.dart';
import 'package:flutter_application_1/screens/dashboard_screen.dart';
import 'package:flutter_application_1/screens/register_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/register': (BuildContext context) => const RegisterScreen(),
    '/dash':(BuildContext context) =>  DashboardScreen(),
    '/login': (BuildContext context) => const LoginScreen(), 
  };
}
