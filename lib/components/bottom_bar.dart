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
    return Column(
      children: <Widget>[
        track == null
            ? Text("")
            : Container(
                width: MediaQuery.of(context).size.width * 1,
                height: 65,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: KeyboardButton(
                                autoFocus: false,
                                icon: Icon(Icons.fast_rewind),
                                onClick: previous,
                              ),
                            ),
                            Expanded(
                              child: KeyboardButton(
                                autoFocus: false,
                                icon: Icon(
                                    isPlaying ? Icons.pause : Icons.play_arrow),
                                onClick: playPause,
                              ),
                            ),
                            Expanded(
                              child: KeyboardButton(
                                autoFocus: false,
                                icon: Icon(Icons.fast_forward),
                                onClick: forward,
                              ),
                            ),
                            Expanded(
                              child: KeyboardButton(
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
                      flex: 6,
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Text(printDuration()),
                              ),
                            ),
                            Expanded(
                              flex: 8,
                              child: Container(
                                child: Slider(
                                  value: duration.inSeconds.toDouble(),
                                  min: 0,
                                  max: track.duration.inSeconds.toDouble(),
                                  divisions: track.duration.inSeconds,
                                  onChanged: (double value) {},
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Text(track.printDuration()),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: track.artwork != null
                                    ? Image.network(track.artwork)
                                    : FlutterLogo(),
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(track.title),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
