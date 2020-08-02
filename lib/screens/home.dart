import 'dart:collection';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:sound_on_fire/components/autocomplete_item.dart';
import 'package:sound_on_fire/components/bottom_bar.dart';
import 'package:sound_on_fire/components/keyboard.dart';
import 'package:sound_on_fire/components/track_tile.dart';
import 'package:sound_on_fire/models/Autocomplete.dart';
import 'package:sound_on_fire/models/Track.dart';
import 'package:sound_on_fire/services/soundcloud.dart' as soundCloudService;

class HomeScreen extends StatefulWidget {
  final String clientId;

  const HomeScreen({Key key, this.clientId}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  static AudioPlayer audioPlayer;

  String searchQuery = "";
  Track selectedTrack;
  List<AutocompleteItem> autocompleteItems = [];
  List<TrackTile> trackTiles = [];
  ListQueue<Track> playlist = ListQueue<Track>();
  Duration currentAudioPosition;

  ScrollController _scrollController;

  @override
  void initState() {
    _initAudioPlayer();
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // print(state);
    if ([
      AppLifecycleState.detached,
      AppLifecycleState.inactive,
      AppLifecycleState.paused,
    ].contains(state)) {
      playPause(forcePause: true);
    }
  }

  void _initAudioPlayer() {
    audioPlayer = AudioPlayer();
    audioPlayer.onAudioPositionChanged.listen((Duration d) {
      setState(() {
        currentAudioPosition = d;
      });
    });
    audioPlayer.onPlayerCompletion.listen((data) {
      setState(() {
        // playlist.removeFirst();
        playlist = ListQueue<Track>.from(playlist.skip(1));
        currentAudioPosition = Duration(seconds: 0);
      });
      if (playlist.isEmpty == false) {
        selectTrack(playlist.first);
      }
    });
  }

  void getAutocomplete(String query) async {
    AutocompleteResponse autocompleteResponse =
        await soundCloudService.queryResults(query, 2, widget.clientId);
    List<AutocompleteItem> tmp = [];
    tmp.add(AutocompleteItem(
      text: query,
      onClick: () => searchTracks(query),
    ));
    for (var response in autocompleteResponse.collection.take(2))
      tmp.add(AutocompleteItem(
        text: response.output,
        onClick: () => searchTracks(response.output),
      ));
    setState(() {
      searchQuery = query;
      autocompleteItems.clear();
      autocompleteItems = tmp;
    });
  }

  void searchTracks(String query) async {
    _scrollController.jumpTo(0);
    getAutocomplete(query);
    SearchResponse searchResponse =
        await soundCloudService.searchTracks(query, 40, widget.clientId);
    List<TrackTile> tmp = [];
    for (var track in searchResponse.collection)
      tmp.add(TrackTile(
        track: track,
        onClick: () => selectTrack(track),
      ));
    setState(() {
      trackTiles.clear();
      trackTiles = tmp;
    });
  }

  void selectTrack(Track track) async {
    String streamUrl = await soundCloudService.getStreamUrl(
      widget.clientId,
      track.id,
      transcodeURL: track.transcodingURL,
    );
    setState(() {
      track.setStreamUrl(streamUrl);
      currentAudioPosition = Duration(seconds: 0);
    });
    setPlaylist(track);
    audioPlayer.play(track.streamUrl);
    await FlutterWindowManager.addFlags(
        FlutterWindowManager.FLAG_KEEP_SCREEN_ON);
  }

  void setPlaylist(Track track) {
    print("Playlist length: ${playlist.length}");
    ListQueue<Track> tmp = ListQueue<Track>();
    bool trackFound = false;
    for (var i = 0; i < trackTiles.length; i++) {
      TrackTile tt = trackTiles[i];
      if (tt.track.id == track.id) {
        trackFound = true;
      }
      if (trackFound) {
        tmp.add(tt.track);
      }
    }
    print("Playlist length: ${tmp.length}");
    setState(() {
      playlist.clear();
      playlist = tmp;
    });
  }

  void onKeyboardAction(String key) {
    if (key == "BACK") {
      if (searchQuery.length > 0) {
        searchQuery = searchQuery.substring(0, searchQuery.length - 1);
      }
    } else if (key == "CLEAR") {
      searchQuery = "";
    } else {
      searchQuery += key;
    }
    if (searchQuery == "") {
      setState(() {
        autocompleteItems.clear();
      });
    } else {
      getAutocomplete(searchQuery);
    }
  }

  void playPause({bool forcePause = false}) async {
    if (playlist.first.streamUrl != null) {
      if (audioPlayer.state == AudioPlayerState.PLAYING || forcePause) {
        await audioPlayer.pause();
        await FlutterWindowManager.clearFlags(
            FlutterWindowManager.FLAG_KEEP_SCREEN_ON);
      } else {
        await audioPlayer.play(playlist.first.streamUrl);
        await FlutterWindowManager.addFlags(
            FlutterWindowManager.FLAG_KEEP_SCREEN_ON);
      }
    }
    setState(() {});
  }

  void fastRewind() {
    if (currentAudioPosition.inSeconds >= 10) {
      audioPlayer.seek(currentAudioPosition + Duration(seconds: -10));
    } else {
      audioPlayer.seek(Duration(seconds: 0));
    }
  }

  void fastForward() {
    if (playlist.first.duration.inSeconds - currentAudioPosition.inSeconds >
        10) {
      audioPlayer.seek(currentAudioPosition + Duration(seconds: 10));
    } else {
      audioPlayer.seek(playlist.first.duration);
    }
  }

  void stop() async {
    await audioPlayer.stop();
    await FlutterWindowManager.clearFlags(
        FlutterWindowManager.FLAG_KEEP_SCREEN_ON);
    setState(() {
      playlist.clear();
    });
  }

  void _handleHardKeyEvents(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.physicalKey == PhysicalKeyboardKey.mediaPlayPause)
        playPause();
      else if (event.physicalKey == PhysicalKeyboardKey.mediaRewind)
        fastRewind();
      else if (event.physicalKey == PhysicalKeyboardKey.mediaFastForward)
        fastForward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RawKeyboardListener(
        focusNode: FocusNode(skipTraversal: true),
        onKey: _handleHardKeyEvents,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  constraints: BoxConstraints.expand(),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 5,
                              child: Keyboard(
                                onKeyboardAction: onKeyboardAction,
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: autocompleteItems,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: ListView(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          children: trackTiles,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              BottomBar(
                playPause: playPause,
                backward: fastRewind,
                forward: fastForward,
                stop: stop,
                track: playlist.isEmpty ? null : playlist.first,
                audioPlayer: audioPlayer,
                currentAudioPosition:
                    playlist.isEmpty || currentAudioPosition == null
                        ? Duration(seconds: 0)
                        : currentAudioPosition,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
