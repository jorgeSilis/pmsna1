import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/Login_screen.dart';
import 'package:flutter_application_1/screens/add_post_screen.dart';
import 'package:flutter_application_1/screens/dashboard_screen.dart';
import 'package:flutter_application_1/screens/events_screen.dart';
import 'package:flutter_application_1/screens/list_popular_videos.dart';
import 'package:flutter_application_1/screens/register_screen.dart';
import 'package:flutter_application_1/widgets/event_form.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/register': (BuildContext context) => const RegisterScreen(),
    '/dash':(BuildContext context) =>  DashboardScreen(),
    '/login': (BuildContext context) => const LoginScreen(),
    '/add': (BuildContext context) =>  AddPostScreen(),  
    '/popular': (BuildContext context) => const ListPopularVideos(),
    '/events': (BuildContext context) => const EventsScreen(),  
    '/edit_event': (BuildContext context) => const EventForm(),
  };
}
