import 'dart:convert';
import 'dart:io';

import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:sound_on_fire/model/QueryResult.dart';
import 'package:sound_on_fire/util/soundcloud.dart';

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
const String clientId = "xTQtEeWzObWW93u9EUTviDSu5Y7Ulk0R";
const String appVersion = "1582892164";
const String appLocale = "en";
const String trackId = "645337329";

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String text = "Click 'Search' to retrieve track";
  bool isPlaying = false;
  var streamURL = "";
  static AudioPlayer audioPlayer;

  void query(text) async {
    setState(() async {
      QueryResponse queryResponse =
          await queryResults(text, clientId, appVersion, appLocale);
      text = queryResponse.collection[0].output;
    });
  }

  void search() async {
    // TODO: init of stream URL, will removed through search
    String stream = await getStreamURL(clientId, trackId);
    print("Setting Track-ID: $trackId with following Stream-URL: $stream");
    setState(() {
      streamURL = stream;
    });
  }

  void playPause() async {
    if (streamURL != null) {
      if (audioPlayer.state == AudioPlayerState.PLAYING) {
        await audioPlayer.pause();
        print("Pause");
        setState(() {
          isPlaying = false;
        });
      } else {
        await audioPlayer.play(streamURL);
        print("Play");
        setState(() {
          isPlaying = true;
        });
      }
    }
  }

  void previous() {
    print("Previous");
    setState(() {
      streamURL = "";
    });
  }

  void forward() {
    print("Forward");
  }

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
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
                queryCallback: query,
                searchCallback: search,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      streamURL == ""
                          ? text
                          : 'Track has been loaded: press Play',
                    ),
                  ],
                ),
              ),
              BottomBar(
                playPause: streamURL == "" ? null : playPause,
                previous: previous,
                forward: forward,
                isPlaying: isPlaying,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderBar extends StatelessWidget {
  Function searchCallback;
  Function queryCallback;

  HeaderBar({this.searchCallback, this.queryCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextField(
              onChanged: queryCallback,
            ),
          ),
          FlatButton(
            onPressed: searchCallback,
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
  Function playPause;
  Function previous;
  Function forward;
  bool isPlaying;

  BottomBar({this.playPause, this.previous, this.forward, this.isPlaying});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: FlatButton(
              onPressed: previous,
              child: Icon(Icons.fast_rewind),
            ),
          ),
          Expanded(
            child: FlatButton(
              onPressed: playPause,
              child: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
            ),
          ),
          Expanded(
            child: FlatButton(
              onPressed: forward,
              child: Icon(Icons.fast_forward),
            ),
          ),
        ],
      ),
    );
  }
}
