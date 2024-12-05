import 'package:flutter/material.dart';
import 'package:flutter_application_sf/theame_notifier.dart';
import 'package:flutter_application_sf/user_name_notifier.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(create: (_) => UsernameNotifier()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = context.watch<ThemeNotifier>().isDarkTheme;

    return MaterialApp(
      title: 'Settings and User Name Manager',
      theme: isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
