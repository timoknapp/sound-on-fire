import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:sound_on_fire/components/autocomplete_item.dart';
import 'package:sound_on_fire/components/bottom_bar.dart';
import 'package:sound_on_fire/components/keyboard.dart';
import 'package:sound_on_fire/components/track_tile.dart';
import 'package:sound_on_fire/models/Autocomplete.dart';
import 'package:sound_on_fire/models/Track.dart';
import 'package:sound_on_fire/services/soundcloud.dart' as soundcloudService;

class HomeScreen extends StatefulWidget {
  final String clientId;

  const HomeScreen({Key key, this.clientId}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  static AudioPlayer audioPlayer;
  static AudioPlayerState audioPlayerState;

  String searchQuery = "";
  Track selectedTrack;
  String selectedTrackUrl;
  List<AutocompleteItem> autocompleteItems = [];
  List<TrackTile> trackTiles = [];
  Duration currentAudioPosition;

  void _initAudioPlayer() {
    audioPlayer = AudioPlayer();
    audioPlayer.onAudioPositionChanged.listen((Duration d) {
      setState(() {
        currentAudioPosition = d;
      });
    });
  }

  @override
  void initState() {
    _initAudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  void getAutocomplete(String query) async {
    AutocompleteResponse autocompleteResponse = await soundcloudService.queryResults(query, 2, widget.clientId);
    List<AutocompleteItem> tmp = [];
    tmp.add(AutocompleteItem(text: query, onClick: () => searchTracks(query),));
    for(var response in autocompleteResponse.collection.take(2))
      tmp.add(AutocompleteItem(text: response.output, onClick: () => searchTracks(response.output),));
    setState(() {
      searchQuery = query;
      autocompleteItems.clear();
      autocompleteItems = tmp;
    });
  }

  void searchTracks(String query) async {
    SearchResponse searchResponse = await soundcloudService.searchTracks(query, 40, widget.clientId);
    List<TrackTile> tmp = [];
    for(var track in searchResponse.collection)
      tmp.add(TrackTile(track: track, onClick: () => selectTrack(track),));
    setState(() {
      trackTiles.clear();
      trackTiles = tmp;
    });
  }

  void selectTrack(Track track) async {
    String streamUrl = await soundcloudService.getStreamUrl(
      widget.clientId,
      track.id,
      transcodeURL: track.transcodingURL,
    );
    audioPlayer.play(streamUrl);
    currentAudioPosition = Duration(seconds: 0);
    setState(() {
      selectedTrack = track;
      selectedTrackUrl = streamUrl;
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

  void playPause() async {
    if (selectedTrackUrl != null) {
      if (audioPlayer.state == AudioPlayerState.PLAYING) {
        await audioPlayer.pause();
      } else {
        await audioPlayer.play(selectedTrackUrl);
      }
    }
    setState(() {});
  }

  void backward() {
    if(currentAudioPosition.inSeconds >= 10) {
      audioPlayer.seek(currentAudioPosition + Duration(seconds: -10));
    } else {
      audioPlayer.seek(Duration(seconds: 0));
    }
  }

  void forward() {
    if(selectedTrack.duration.inSeconds - currentAudioPosition.inSeconds > 10) {
      audioPlayer.seek(currentAudioPosition + Duration(seconds: 10));
    } else {
      audioPlayer.seek(selectedTrack.duration);
    }
  }

  void stop() async {
    await audioPlayer.stop();
    selectedTrack = null;
    selectedTrackUrl = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
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
                        scrollDirection: Axis.horizontal,
                        children: trackTiles,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BottomBar(
              playPause: selectedTrackUrl == "" ? null : playPause,
              backward: backward,
              forward: forward,
              stop: stop,
              track: selectedTrack,
              audioPlayer: audioPlayer,
              currentAudioPosition: currentAudioPosition,
            ),
          ],
        ),
      )
    );
  }

}