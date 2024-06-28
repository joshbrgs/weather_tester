import 'package:flutter/material.dart';
import 'pages/weather_page.dart';

import 'components/theme_style.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';

void main() async {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeDataStyle,
      home: const WeatherPage(),
    );
  }
}
