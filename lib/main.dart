import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sound_on_fire/screens/loading.dart';
import 'package:sound_on_fire/util/constants.dart';

void main() => runApp(MyApp());

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
          primarySwatch: primaryMaterialColor,
        ),
        home: LoadingScreen(),
      ),
    );
  }
}
