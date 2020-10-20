import 'package:flutter/material.dart';
import 'package:sound_on_fire/components/autocomplete_item.dart';
import 'package:sound_on_fire/components/input_area.dart';
import 'package:sound_on_fire/components/result_area.dart';
import 'package:sound_on_fire/components/track_tile.dart';

class MainArea extends StatelessWidget {
  const MainArea({
    @required this.autocompleteItems,
    @required this.onKeyboardAction,
    @required this.isAlphabeticalKeyboard,
    @required ScrollController scrollController,
    @required this.trackTiles,
  }) : _scrollController = scrollController;

  final List<AutocompleteItem> autocompleteItems;
  final Function onKeyboardAction;
  final bool isAlphabeticalKeyboard;
  final ScrollController _scrollController;
  final List<TrackTile> trackTiles;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // Main Content
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        constraints: BoxConstraints.expand(),
        child: Column(
          children: <Widget>[
            InputArea(
              autocompleteItems: autocompleteItems,
              onKeyboardAction: onKeyboardAction,
              isAlphabeticalKeyboard: isAlphabeticalKeyboard,
            ),
            ResultArea(
              scrollController: _scrollController,
              trackTiles: trackTiles,
            ),
          ],
        ),
      ),
    );
  }
}
