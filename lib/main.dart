import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:sound_on_fire/model/Query.dart';
import 'package:sound_on_fire/model/Search.dart';
import 'package:sound_on_fire/util/soundcloud.dart' as soundcloud;

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
  String clientId = "";
  String text = "Click 'Search' to retrieve track";
  String searchInput;
  List<Text> queryResult = [];
  bool isPlaying = false;
  var streamURL = "";
  static AudioPlayer audioPlayer;

  void query(input) async {
    QueryResponse queryResponse =
        await soundcloud.queryResults(input, clientId);
    setState(() {
      searchInput = input;
      queryResult.clear();
      if (queryResponse.collection.length > 0) {
        for (var result in queryResponse.collection.take(5).toList()) {
          queryResult.add(Text(result.output));
        }
      }
    });
  }

  void search() async {
    SearchResponse searchResponse =
        await soundcloud.searchResults(searchInput, clientId);
    String stream = "";
    //TODO: temporarily select first result as selected track
    if (searchResponse.collection.length > 0) {
      stream = await soundcloud.getStreamURL(
          clientId, searchResponse.collection[0].id,
          transcodeURL: searchResponse.collection[0].transcodingURL);
    }
    setState(() {
      streamURL = stream;
      queryResult.clear();
      if (searchResponse.collection.length > 0) {
        for (var result in searchResponse.collection) {
          queryResult.add(Text(
              '${result.title} - ${result.printDuration()} - ${result.playbackCount} played'));
        }
      }
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

  void _getClientId() async {
    String id = await soundcloud.getClientID();
    print('Client ID: $id');
    setState(() {
      clientId = id;
    });
  }

  @override
  void initState() {
    _getClientId();
    audioPlayer = AudioPlayer();
    super.initState();
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
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  constraints: BoxConstraints.expand(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: queryResult.isEmpty
                        ? [
                            Text(
                              streamURL == ""
                                  ? text
                                  : 'Track has been loaded: press Play',
                            ),
                          ]
                        : queryResult,
                  ),
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
  final Function searchCallback;
  final Function queryCallback;

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
  final Function playPause;
  final Function previous;
  final Function forward;
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
