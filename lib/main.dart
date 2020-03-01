import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sound_on_fire/model/QueryResult.dart';

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

// const String app_id = 1e3*String(Date.now()).substr(-8)+Math.floor(1e3*Math.random())
const String client_id = "xTQtEeWzObWW93u9EUTviDSu5Y7Ulk0R";
const String app_version = "1582892164";
const String app_locale = "en";

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String text = "Music will be played here";

  void query(text) async {
    setState(() async {
      QueryResponse queryResponse = await search(text);
      text = queryResponse.collection[0].output;
    });
  }

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
          title: Text('SoundCloud @ 🔥📺'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              HeaderBar(
                searchCallback: query,
              ),
              Expanded(
                child: Text(
                  text,
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
  Function searchCallback;

  HeaderBar({this.searchCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextField(
              onChanged: searchCallback,
            ),
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

Future<QueryResponse> search(String query) async {
  final response = await http.get(
      'https://api-v2.soundcloud.com/search/queries?q=$query&client_id=$client_id&limit=10&offset=0&linked_partitioning=1&app_version=$app_version&app_locale=$app_locale');

  print('Response Status-Code: ${response.statusCode}');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    print(response.body);
    return QueryResponse.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to query results');
  }
}
