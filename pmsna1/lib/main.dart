import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/theme_provider.dart';
import 'package:flutter_application_1/routes.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(context)),
      ],
      child: PMSNApp(),
    );
  }
}

class PMSNApp extends StatelessWidget {
  const PMSNApp({super.key});


  @override
  Widget build(BuildContext context) {
    
  ThemeProvider theme = Provider.of<ThemeProvider>(context);
    return MaterialApp(
        theme: theme.getThemeData(),
        routes: getApplicationRoutes(), home: const LoginScreen());
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