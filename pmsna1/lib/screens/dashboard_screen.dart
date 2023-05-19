import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase/email_auth.dart';
import 'package:flutter_application_1/provider/theme_provider.dart';
import 'package:flutter_application_1/screens/list_favorites_cloud.dart';
import 'package:flutter_application_1/screens/list_post.dart';
import 'package:flutter_application_1/settings/styles_settings.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key, required this.userCredential, });

  final EmailAuthClass userCredential; 

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isDarkModeEnabled = false;
  Map aux = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.userCredential.userCredential.user?.providerData != null) {
      var data = widget.userCredential.userCredential.user?.providerData[0];
      aux = Map.from({
        'email': data?.email,
        'photoURL': data?.photoURL,
        'name': data?.displayName,
        'providerId': data?.providerId
      });
    } else {
      var data = widget.userCredential.userCredential.user;
      aux = Map.from({
        'email': data?.email,
        'photoURL': data?.photoURL,
        'name': data?.displayName,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Social tec :D'),
      ),
      body: const ListPost(), //ListFavoritesCloud(),,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        label: const Text('Add post!'),
        icon: const Icon(Icons.add_comment),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(aux['photoURL'])),
                accountName: Text(aux['name']),
                accountEmail: Text(aux['email'])),
            ListTile(
                onTap: () {},
                title: Text('Practica 1'),
                subtitle: Text('Descripcion de la practica'),
                leading: Icon(Icons.settings),
                trailing: Icon(Icons.chevron_right)),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/popular');
              },
              title: Text('API videos'),
              leading: Icon(Icons.movie),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/map');
              },
              title: Text('Maps :D'),
              leading: Icon(Icons.map_outlined),
              trailing: Icon(Icons.chevron_right),
            ),
          ],
        ),
      ),
    );
  }
}
