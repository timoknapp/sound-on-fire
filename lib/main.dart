import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sound_on_fire/screens/loading.dart';
import 'package:sound_on_fire/util/constants.dart';

void main() => runApp(SoundOnFireApp());

class SoundOnFireApp extends StatefulWidget {
  @override
  _SoundOnFireAppState createState() => _SoundOnFireAppState();
}

class _SoundOnFireAppState extends State<SoundOnFireApp> {
  final Map<LogicalKeySet, Intent> _shortcuts = {
    LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),//Intent(ActivateAction.key),
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
