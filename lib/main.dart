import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sound_on_fire/screens/home.dart';
import 'package:sound_on_fire/screens/loading.dart';

void main() => runApp(MyApp());

const MaterialColor color_sc = const MaterialColor(
  0xffff5500,
  const <int, Color>{
    50: const Color(0xffff5500),
    100: const Color(0xffff5500),
    200: const Color(0xffff5500),
    300: const Color(0xffff5500),
    400: const Color(0xffff5500),
    500: const Color(0xffff5500),
    600: const Color(0xffff5500),
    700: const Color(0xffff5500),
    800: const Color(0xffff5500),
    900: const Color(0xffff5500),
  },
);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Map<LogicalKeySet, Intent> _shortcuts = {
    LogicalKeySet(LogicalKeyboardKey.select): const Intent(ActivateAction.key),
  };

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: _shortcuts,
      child: MaterialApp(
        title: 'SoundOnFire',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: color_sc,
        ),
        home: LoadingScreen()
      ),
    );
  }
}
