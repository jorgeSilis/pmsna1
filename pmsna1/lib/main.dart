import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/flags_provider.dart';
import 'package:flutter_application_1/provider/theme_provider.dart';
import 'package:flutter_application_1/routes.dart';
import 'package:flutter_application_1/screens/Login_screen.dart';
import 'package:flutter_application_1/screens/onboarding_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(context)),
        ChangeNotifierProvider(create: (_) => FlagsProvider())
      ],
      child: PMSNApp(),
    );
  }
}

class PMSNApp extends StatelessWidget {
  const PMSNApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeData = themeProvider.getThemeData();

    return MaterialApp(
      theme: themeData,
      routes: getApplicationRoutes(),
      //home: LoginScreen(),
      home: OnboardingPage(),
    );
  }
}

/*import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hola mundo'),
        ),
        body: Center(
            child: ListView(
          shrinkWrap: true,
          children: const [
            Text(
              '0',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
            Text(
              'Contador de Clicks',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
          ],
        )),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.ads_click),
          onPressed: () {},
        ),
      ),
    );
  }
}
*/