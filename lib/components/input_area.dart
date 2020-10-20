import 'package:flutter/material.dart';
import 'package:sound_on_fire/components/autocomplete_item.dart';
import 'package:sound_on_fire/components/keyboard.dart';

class InputArea extends StatelessWidget {
  InputArea({
    @required this.autocompleteItems,
    @required this.onKeyboardAction,
    @required this.isAlphabeticalKeyboard,
  });

  final List<AutocompleteItem> autocompleteItems;
  final Function onKeyboardAction;
  final bool isAlphabeticalKeyboard;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 9,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: autocompleteItems,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 8,
            child: Keyboard(
              onKeyboardAction: onKeyboardAction,
              isAlphabeticalKeyboard: isAlphabeticalKeyboard,
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image(
                  image: AssetImage('images/pb_soundcloud2.png'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
