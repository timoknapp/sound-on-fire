import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sound_on_fire/components/header_bar.dart';
import 'package:sound_on_fire/components/keyboard.dart';
import 'package:sound_on_fire/components/list_element.dart';
import 'package:sound_on_fire/model/Query.dart';
import 'package:sound_on_fire/model/Search.dart';
import 'package:sound_on_fire/util/soundcloud.dart' as soundcloud;

import 'components/bottom_bar.dart';

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
  List<ListElement> queryResults = [];
  List<ListElement> searchResults = [];
  bool isPlaying = false;
  var streamURL = "";
  SearchResult selectedTrack;
  static AudioPlayer audioPlayer;
  AudioPlayerState audioPlayerState;
  // FocusNode inputFocus;

  final Map<LogicalKeySet, Intent> _shortcuts = {
    LogicalKeySet(LogicalKeyboardKey.select): const Intent(ActivateAction.key),
  };

  void query(input) async {
    print("Query: $input");
    QueryResponse queryResponse =
        await soundcloud.queryResults(input, clientId);
    List<ListElement> tmp = [];
    tmp.add(ListElement(
      title: input,
      onClick: () {
        search();
      },
    ));
    if (queryResponse.collection.length > 0) {
      for (var result in queryResponse.collection.take(2).toList()) {
        tmp.add(ListElement(
          title: result.output,
          onClick: () {
            searchInput = result.output;
            search();
          },
        ));
      }
    }
    setState(() {
      searchInput = input;
      queryResults.clear();
      queryResults = tmp;
    });
  }

  void search() async {
    print("Search: $searchInput | $clientId");
    SearchResponse searchResponse =
        await soundcloud.searchResults(searchInput, clientId);
    List<ListElement> tmp = [];
    if (searchResponse.collection.length > 0) {
      for (var result in searchResponse.collection) {
        print(result.title);
        tmp.add(
          ListElement(
            title: result.title,
            subtitle:
                '${result.printDuration()} -  ${result.playbackCount} plays',
            imageUrl: result.artwork,
            onClick: () {
              selectTrack(result);
            },
          ),
        );
      }
    }
    setState(() {
      searchResults.clear();
      searchResults = tmp;
    });
  }

  void keyboardInput(key) {
    print(key);
    String input = searchInput;
    if (key == "BACK") {
      if (input.length > 0) {
        input = input.substring(0, input.length - 1);
      }
    } else if (key == "CLEAR") {
      input = "";
    } else {
      input += key;
    }
    setState(() {
      searchInput = input;
      if (key == "CLEAR") {
        queryResults.clear();
      }
    });
    if (input.isNotEmpty) {
      query(input);
    }
  }

  // void inputFocusListener() {
  //   print(
  //       "Has focus: ${inputFocus.hasFocus} | has primary focus: ${inputFocus.hasPrimaryFocus}");
  //   setState(() {});
  // }

  void selectTrack(SearchResult track) async {
    String stream = await soundcloud.getStreamURL(
      clientId,
      track.id,
      transcodeURL: track.transcodingURL,
    );
    setState(() {
      selectedTrack = track;
      streamURL = stream;
    });
    await audioPlayer.play(stream);
  }

  void playPause() async {
    if (streamURL != null) {
      if (audioPlayer.state == AudioPlayerState.PLAYING) {
        await audioPlayer.pause();
        print("Pause");
        // setState(() {
        //   isPlaying = false;
        // });
      } else {
        await audioPlayer.play(streamURL);
        print("Play");
        // setState(() {
        //   isPlaying = true;
        // });
      }
    }
  }

  void previous() {
    print("Previous");
  }

  void forward() {
    print("Forward");
  }

  void stop() async {
    print("Stop");
    await audioPlayer.stop();
    setState(() {
      streamURL = "";
      isPlaying = false;
      selectedTrack = null;
    });
  }

  void _getClientId() async {
    String id = await soundcloud.getClientID();
    print('Client ID: $id');
    setState(() {
      clientId = id;
    });
  }

  void _initAudioPlayer() {
    audioPlayer = AudioPlayer();

    audioPlayer.onPlayerStateChanged.listen((state) {
      if (!mounted) return;
      setState(() {
        if (state == AudioPlayerState.PLAYING) {
          isPlaying = true;
        } else {
          isPlaying = false;
        }
        audioPlayerState = state;
      });
    });
  }

  @override
  void initState() {
    queryResults.clear();
    searchResults.clear();
    _getClientId();
    _initAudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    queryResults.clear();
    searchResults.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: _shortcuts,
      child: MaterialApp(
        title: 'SoundCloud',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: color_sc,
        ),
        home: Scaffold(
          appBar: clientId.isEmpty
              ? AppBar(
                  title: Text('Loading ...'),
                )
              : null,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    constraints: BoxConstraints.expand(),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Keyboard(
                                  onKeyboardAction: keyboardInput,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: queryResults,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: searchResults,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                BottomBar(
                  playPause: streamURL == "" ? null : playPause,
                  previous: previous,
                  forward: forward,
                  stop: stop,
                  isPlaying: isPlaying,
                  track: selectedTrack,
                  player: audioPlayer,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
