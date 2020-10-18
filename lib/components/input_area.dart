import 'package:flutter/material.dart';
import 'package:sound_on_fire/components/autocomplete_item.dart';
import 'package:sound_on_fire/components/keyboard.dart';
import 'package:sound_on_fire/util/constants.dart';

class InputArea extends StatelessWidget {
  InputArea({
    @required this.autocompleteItems,
    @required this.onKeyboardAction,
  });

  final List<AutocompleteItem> autocompleteItems;
  final Function onKeyboardAction;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        color: lightBackground,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Keyboard(
                onKeyboardAction: onKeyboardAction,
              ),
            ),
            Expanded(
              flex: 9,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: autocompleteItems,
                ),
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
      ),
    );
  }
}
