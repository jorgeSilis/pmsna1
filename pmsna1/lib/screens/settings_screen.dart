import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/theme_provider.dart';
import 'package:flutter_application_1/settings/styles_settings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Selecciona un tema',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => theme.setThemeData('dark', context),
              child: const Text('Modo noche'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => theme.setThemeData('light', context),
              child: const Text('Modo día'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => theme.setThemeData('chill', context),
              child: const Text('Modo chill'),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Tema guardado')),
                    );

                    // Cerrar la pantalla de configuración
                    Navigator.pop(context);
                  },
                  child: const Text('Acceptar'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    theme.setThemeData('light', context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Cambios revertidos')),
                    );
                  },
                  child: const Text('Cancelar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
