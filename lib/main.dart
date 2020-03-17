import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:sound_on_fire/components/keyboard.dart';
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
  String searchInput = "";
  List<ListElement> results = [];
  bool isPlaying = false;
  var streamURL = "";
  String selectedTrack = "No track selected";
  static AudioPlayer audioPlayer;
  FocusNode inputFocus;

  void query(input) async {
    print("Query: $input");
    QueryResponse queryResponse =
        await soundcloud.queryResults(input, clientId);
    setState(() {
      searchInput = input;
      results.clear();
      if (queryResponse.collection.length > 0) {
        for (var result in queryResponse.collection.take(5).toList()) {
          results.add(ListElement(
            text: result.output,
            onClick: () {
              search();
            },
          ));
        }
      }
    });
  }

  void search() async {
    // TODO: remove focus statement here, if not eplicitly needed
    FocusScope.of(context).unfocus();
    print("Search");
    SearchResponse searchResponse =
        await soundcloud.searchResults(searchInput, clientId);
    setState(() {
      results.clear();
      if (searchResponse.collection.length > 0) {
        for (var result in searchResponse.collection) {
          results.add(
            ListElement(
              text:
                  '${result.title} - ${result.printDuration()} - ${result.playbackCount} played',
              onClick: () {
                selectTrack(result);
              },
            ),
          );
        }
      }
    });
  }

  void keyboardInput(key) {
    print(key);
    String input = searchInput;
    if (key == "BACK") {
      if (input.length > 0) {
        input = input.substring(0, input.length - 1);
      }
    } else {
      input += key;
    }
    setState(() {
      searchInput = input;
    });
    if (input.isNotEmpty) {
      query(input);
    }
  }

  void inputFocusListener() {
    print(
        "Has focus: ${inputFocus.hasFocus} | has primary focus: ${inputFocus.hasPrimaryFocus}");
    setState(() {});
  }

  void selectTrack(SearchResult track) async {
    String stream = await soundcloud.getStreamURL(
      clientId,
      track.id,
      transcodeURL: track.transcodingURL,
    );
    setState(() {
      selectedTrack = track.title;
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

  void _getClientId() async {
    String id = await soundcloud.getClientID();
    print('Client ID: $id');
    setState(() {
      clientId = id;
    });
  }

  @override
  void initState() {
    results.clear();
    _getClientId();
    audioPlayer = AudioPlayer();
    inputFocus = FocusNode();
    inputFocus.addListener(() {
      inputFocusListener();
    });
    super.initState();
  }

  @override
  void dispose() {
    inputFocus.dispose();
    results.clear();
    super.dispose();
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
          title: Text(clientId.isEmpty ? 'Loading ...' : 'SoundCloud @ 🔥📺'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              HeaderBar(
                queryCallback: query,
                searchCallback: search,
                inputText: searchInput,
                inputFocus: inputFocus,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  constraints: BoxConstraints.expand(),
                  child: inputFocus.hasPrimaryFocus
                      ? Row(
                          children: <Widget>[
                            Expanded(
                              flex: 5,
                              child: Keyboard(
                                onKeyboardAction: keyboardInput,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: results,
                                ),
                              ),
                            )
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: results,
                        ),
                ),
              ),
              BottomBar(
                playPause: streamURL == "" ? null : playPause,
                previous: previous,
                forward: forward,
                isPlaying: isPlaying,
                trackName: selectedTrack,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListElement extends StatelessWidget {
  final Function onClick;
  final String text;

  ListElement({this.text, this.onClick});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onClick,
      child: new Text(
        text,
      ),
    );
  }
}

class HeaderBar extends StatelessWidget {
  final Function searchCallback;
  final Function queryCallback;
  final String inputText;
  final FocusNode inputFocus;

  HeaderBar({
    this.searchCallback,
    this.queryCallback,
    this.inputText,
    this.inputFocus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextField(
              onChanged: queryCallback,
              decoration: InputDecoration(
                hintText: 'Please enter a search term',
                contentPadding: const EdgeInsets.all(20.0),
              ),
              onEditingComplete: () {
                print("edit Complete");
                FocusScope.of(context).unfocus();
                searchCallback();
              },
              focusNode: inputFocus,
              controller: TextEditingController(text: inputText),
              readOnly: true,
              showCursor: true,
              // onSubmitted: (text) {
              //   print("Submit");
              //   FocusScope.of(context).unfocus();
              //   searchCallback();
              // },
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
  final bool isPlaying;
  final String trackName;

  BottomBar(
      {this.playPause,
      this.previous,
      this.forward,
      this.isPlaying,
      this.trackName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(trackName),
        Container(
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
        ),
      ],
    );
  }
}
