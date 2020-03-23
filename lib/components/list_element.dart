import 'package:flutter/material.dart';
import 'package:sound_on_fire/model/Search.dart';

class ListElement extends StatelessWidget {
  final Function onClick;
  final SearchResult result;

  ListElement({
    @required this.onClick,
    @required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      focusColor: Color(0xffff5500),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.20,
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
                    child: result.artwork != null
                        ? Image.network(result.artwork)
                        : FlutterLogo(
                            size: 100,
                          ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  result.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  result.printDuration(),
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '${result.printPlaycount()} played',
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${result.printUploadSince()} · ${result.printLikescount()} 🖤',
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
