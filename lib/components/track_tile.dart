import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sound_on_fire/models/Track.dart';

class TrackTile extends StatelessWidget {
  final Track track;
  final void Function() onClick;
  final bool isLoading;

  TrackTile({
    required this.track,
    required this.onClick,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      focusColor: Colors.grey[500],
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.20,
        child: Card(
          color: Colors.grey[100],
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: isLoading
                ? ShimmerTrackTileContent(key: UniqueKey())
                : TrackTileContent(key: UniqueKey(), track: track),
          ),
        ),
      ),
    );
  }
}

class TrackTileContent extends StatelessWidget {
  const TrackTileContent({
    required Key key,
    required this.track,
  }) : super(key: key);

  final Track track;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Container(
            height: 100,
            child: track.artwork != null
                ? Image.network(track.artwork!)
                : FlutterLogo(
                    size: 100,
                  ),
          ),
        ),
        SizedBox(height: 5),
        Text(
          track.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          track.printDuration(),
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: 5),
        Text(
          '${track.printPlaycount()} played',
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.black87,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          '${track.printUploadSince()} · ${track.printLikescount()} 🖤',
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}

class ShimmerTrackTileContent extends StatelessWidget {
  const ShimmerTrackTileContent({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            Colors.grey[350]!,
            Colors.grey[350]!,
            Colors.grey[500]!,
            Colors.grey[350]!,
            Colors.grey[350]!
          ],
          stops: const <double>[
            0.0,
            0.35,
            0.5,
            0.65,
            1.0
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
              height: 100,
              width: 100,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Container(
            width: double.infinity,
            height: 16.0,
            color: Colors.white,
          ),
          SizedBox(height: 5),
          Container(
            width: 40,
            height: 8.0,
            color: Colors.white,
          ),
          SizedBox(height: 5),
          Container(
            width: 60,
            height: 8.0,
            color: Colors.white,
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: 150,
            height: 8.0,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
