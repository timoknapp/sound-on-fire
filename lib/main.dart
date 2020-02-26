import 'package:flutter/material.dart';

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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SoundCloud',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: color_sc,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('SoundCloud'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              HeaderBar(),
              Expanded(
                child: Text(
                  'Music will be played here',
                ),
              ),
              BottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextField(),
          ),
          FlatButton(
            onPressed: () {},
            child: Text(
              'Search',
            ),
          ),
        ],
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: FlatButton(
              onPressed: () {},
              child: Icon(Icons.fast_rewind),
            ),
          ),
          Expanded(
            child: FlatButton(
              onPressed: () {},
              child: Icon(Icons.play_arrow),
            ),
          ),
          Expanded(
            child: FlatButton(
              onPressed: () {},
              child: Icon(Icons.fast_forward),
            ),
          ),
        ],
      ),
    );
  }
}
