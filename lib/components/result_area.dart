import 'package:flutter/material.dart';
import 'package:sound_on_fire/components/track_tile.dart';
import 'package:sound_on_fire/util/constants.dart';

class ResultArea extends StatelessWidget {
  ResultArea({
    required ScrollController scrollController,
    required this.trackTiles,
    required this.isLoading,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final List<TrackTile> trackTiles;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: ListView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        children: isLoading ? shimmerTrackTiles : trackTiles,
      ),
    );
  }
}
