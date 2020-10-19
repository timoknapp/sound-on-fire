import 'package:flutter/material.dart';
import 'package:sound_on_fire/models/Track.dart';
import 'package:sound_on_fire/util/constants.dart';

class TrackTile extends StatelessWidget {
  final Track track;
  final Function onClick;

  TrackTile({
    @required this.track,
    @required this.onClick,
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
        width: MediaQuery.of(context).size.width * 0.195,
        child: Card(
          color: Colors.grey[100],
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Container(
                    height: 100,
                    child: track.artwork != null
                        ? Image.network(track.artwork)
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
            ),
          ),
        ),
      ),
    );
  }
}
