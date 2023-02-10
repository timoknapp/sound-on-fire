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
    @required this.isLoading,
    @required this.isDarkModeEnabled,
    @required this.toggleDarkMode,
  }) : _scrollController = scrollController;

  final List<AutocompleteItem> autocompleteItems;
  final Function onKeyboardAction;
  final bool isAlphabeticalKeyboard;
  final ScrollController _scrollController;
  final List<TrackTile> trackTiles;
  final bool isLoading;
  final bool isDarkModeEnabled;
  final Function toggleDarkMode;

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
              isLoading: isLoading,
              isDarkModeEnabled: isDarkModeEnabled,
              toggleDarkMode: toggleDarkMode,
            ),
            ResultArea(
              scrollController: _scrollController,
              trackTiles: trackTiles,
              isLoading: isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
