import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:sound_on_fire/components/small_button.dart';
import 'package:sound_on_fire/models/Track.dart';
import 'package:sound_on_fire/util/constants.dart';

class BottomBar extends StatelessWidget {
  final void Function() playPause;
  final void Function() backward;
  final void Function() forward;
  final void Function() stop;
  final Track track;
  final AudioPlayer audioPlayer;
  final Duration currentAudioPosition;

  BottomBar({
    required this.playPause,
    required this.backward,
    required this.forward,
    required this.stop,
    required this.track,
    required this.audioPlayer,
    required this.currentAudioPosition,
  });

  String printDuration() {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes =
        twoDigits(this.currentAudioPosition.inMinutes.remainder(60));
    String twoDigitSeconds =
        twoDigits(this.currentAudioPosition.inSeconds.remainder(60));
    return "${twoDigits(this.currentAudioPosition.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: lighterGrey,
      width: MediaQuery.of(context).size.width * 1,
      height: 65,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: SmallButton(
                      autoFocus: false,
                      icon: Icon(Icons.fast_rewind),
                      onClick: track.isNull() ? () {} : backward,
                    ),
                  ),
                  Expanded(
                    child: SmallButton(
                      autoFocus: false,
                      icon: Icon(audioPlayer.state != PlayerState.playing
                          ? Icons.play_arrow
                          : Icons.pause),
                      onClick: track.isNull() ? () {} : playPause,
                    ),
                  ),
                  Expanded(
                    child: SmallButton(
                      autoFocus: false,
                      icon: Icon(Icons.fast_forward),
                      onClick: track.isNull() ? () {} : forward,
                    ),
                  ),
                  Expanded(
                    child: SmallButton(
                      autoFocus: false,
                      icon: Icon(Icons.stop),
                      onClick: stop,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      // padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(track.isNull() == false && currentAudioPosition != Duration.zero
                          ? printDuration()
                          : ""),
                    ),
                  ),
                  Expanded(
                    flex: 12,
                    child: Container(
                      child: track.isNull() == false && currentAudioPosition != Duration.zero
                          ? Slider(
                              value: currentAudioPosition.inSeconds.toDouble(),
                              min: 0.0,
                              max: track.duration.inSeconds.toDouble(),
                              divisions: null,
                              onChanged: null,
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  appTitle,
                                  style: const TextStyle(
                                    color: primaryOrange,
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  track.isNull() == false
                      ? Expanded(
                          flex: 2,
                          child: Container(
                            // padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(track.printDuration()),
                          ),
                        )
                      : Text(""),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: track.isNull() == false
                        ? Container(
                            child: track.artwork != null
                                ? Image.network(track.artwork!)
                                : FlutterLogo(),
                          )
                        : Text(""),
                  ),
                  Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          track.isNull() == false ? track.title : "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
