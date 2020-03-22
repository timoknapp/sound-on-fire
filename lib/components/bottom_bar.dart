import 'package:flutter/material.dart';

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
