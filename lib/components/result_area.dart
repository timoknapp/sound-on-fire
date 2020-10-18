import 'package:flutter/material.dart';
import 'package:sound_on_fire/components/track_tile.dart';
import 'package:sound_on_fire/util/constants.dart';

class ResultArea extends StatelessWidget {
  ResultArea({
    @required ScrollController scrollController,
    @required this.trackTiles,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final List<TrackTile> trackTiles;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Container(
        color: lightBackground,
        child: ListView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          children: trackTiles,
        ),
      ),
    );
  }
}
