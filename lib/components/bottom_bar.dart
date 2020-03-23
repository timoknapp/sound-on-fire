import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:sound_on_fire/components/keyboard.dart';
import 'package:sound_on_fire/model/Search.dart';

class BottomBar extends StatelessWidget {
  final Function playPause;
  final Function previous;
  final Function forward;
  final Function stop;
  final bool isPlaying;
  final SearchResult track;
  final AudioPlayer player;
  final Duration duration;

  BottomBar({
    this.playPause,
    this.previous,
    this.forward,
    this.stop,
    this.isPlaying,
    this.track,
    this.player,
    this.duration,
  });

  String printDuration() {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(this.duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(this.duration.inSeconds.remainder(60));
    return "${twoDigits(this.duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    child: KeyboardButton(
                      autoFocus: false,
                      icon: Icon(Icons.fast_rewind),
                      onClick: track != null ? previous : null,
                    ),
                  ),
                  Expanded(
                    child: KeyboardButton(
                      autoFocus: false,
                      icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                      onClick: track != null ? playPause : null,
                    ),
                  ),
                  Expanded(
                    child: KeyboardButton(
                      autoFocus: false,
                      icon: Icon(Icons.fast_forward),
                      onClick: track != null ? forward : null,
                    ),
                  ),
                  Expanded(
                    child: KeyboardButton(
                      autoFocus: false,
                      icon: Icon(Icons.stop),
                      onClick: track != null ? stop : null,
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
                      child: Text(track != null ? printDuration() : ""),
                    ),
                  ),
                  Expanded(
                    flex: 12,
                    child: Container(
                      child: track != null
                          ? Slider(
                              value: duration.inSeconds.toDouble(),
                              min: 0,
                              max: track.duration.inSeconds.toDouble(),
                              divisions: track.duration.inSeconds,
                              onChanged: (double value) {},
                            )
                          : Text("no selection"),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      // padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(track != null ? track.printDuration() : ""),
                    ),
                  ),
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
                    child: track != null
                        ? Container(
                            child: track.artwork != null
                                ? Image.network(track.artwork)
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
                          track != null ? track.title : "",
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
