import 'dart:collection';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:sound_on_fire/components/autocomplete_item.dart';
import 'package:sound_on_fire/components/bottom_bar.dart';
import 'package:sound_on_fire/components/main_area.dart';
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

  int searchLimit = 10;
  String searchQuery = "";
  Track selectedTrack;
  List<AutocompleteItem> autocompleteItems = [];
  List<TrackTile> trackTiles = [];
  ListQueue<Track> playlist = ListQueue<Track>();
  Duration currentAudioPosition;

  ScrollController _scrollController;

  void _scrollControlListener() {
    double refreshOffset = _scrollController.position.maxScrollExtent;
    // print(
    //     "Offset: ${_scrollController.offset}, maxScrollExtent: ${_scrollController.position.maxScrollExtent}, OutOfRange: ${_scrollController.position.outOfRange}");
    if (_scrollController.offset >= refreshOffset &&
        !_scrollController.position.outOfRange) {
      // print("refresh: tracks: ${trackTiles.length}");
      if (searchQuery.isNotEmpty) {
        searchTracks(searchQuery, searchLimit, trackTiles.length);
      }
    }
  }

  @override
  void initState() {
    _initAudioPlayer();
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollControlListener);
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
      onClick: () => initSearchTracks(query, searchLimit, 0),
    ));
    for (var response in autocompleteResponse.collection.take(2))
      tmp.add(AutocompleteItem(
        text: response.output,
        onClick: () => initSearchTracks(response.output, searchLimit, 0),
      ));
    setState(() {
      searchQuery = query;
      autocompleteItems.clear();
      autocompleteItems = tmp;
    });
  }

  void searchTracks(String query, int limit, int offset) async {
    // print("search: offset=$offset limit=$limit");
    SearchResponse searchResponse = await soundCloudService.searchTracks(
        query, limit, offset, widget.clientId);
    List<TrackTile> tmp = []..addAll(trackTiles);
    for (var track in searchResponse.collection)
      tmp.add(TrackTile(
        track: track,
        onClick: () => selectTrack(track),
      ));
    // print("search: response=${tmp.length} trackTiles=${trackTiles.length}");
    setState(() {
      trackTiles.clear();
      trackTiles = tmp;
    });
  }

  void initSearchTracks(String query, int limit, int offset) async {
    if (offset == 0) {
      trackTiles.clear();
      getAutocomplete(query);
      await searchTracks(query, limit, offset);
      _scrollController.jumpTo(0);
    }
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
    // print("Playlist length: ${playlist.length}");
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
    // print("Playlist length: ${tmp.length}");
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
                // Top Margin
                height: 5,
              ),
              MainArea(
                  autocompleteItems: autocompleteItems,
                  onKeyboardAction: onKeyboardAction,
                  scrollController: _scrollController,
                  trackTiles: trackTiles),
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
