import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        track == null
            ? Text('No track selected')
            : Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
                margin: EdgeInsets.symmetric(vertical: 0),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  selected: isPlaying == true ? true : false,
                  leading: track.artwork != null
                      ? Image.network(track.artwork)
                      : null,
                  title: Text(track.title),
                  subtitle: Row(
                    children: <Widget>[
                      Text(
                          '${track.printDuration()} -  ${track.playbackCount} plays'),
                    ],
                  ),
                  trailing: FlatButton(
                    onPressed: stop,
                    child: Icon(Icons.stop),
                  ),
                ),
              ),
        track == null ?
            Text("") :
        Slider(
          value: duration.inSeconds.toDouble(),
          min: 0,
          max: track.duration.inSeconds.toDouble(),
          divisions: track.duration.inSeconds,
          onChanged: (double value) {},
        ),
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
