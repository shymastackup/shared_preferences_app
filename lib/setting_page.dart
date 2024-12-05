import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theame_notifier.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = context.watch<ThemeNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Dark Theme'),
              value: themeNotifier.isDarkTheme,
              onChanged: (value) => themeNotifier.updateTheme(value),
            ),
            SwitchListTile(
              title: const Text('Enable Notifications'),
              value: themeNotifier.notificationsEnabled,
              onChanged: (value) => themeNotifier.updateNotifications(value),
            ),
          ],
        ),
      ),
    );
  }
}
