import 'package:flutter/material.dart';
import 'package:sound_on_fire/util/constants.dart';

class AutocompleteItem extends StatelessWidget {
  final String text;
  final Function onClick;

  const AutocompleteItem({Key key, this.text, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColorLightMode2,
      child: ListTile(
        title: Text(text),
        onTap: onClick,
      ),
    );
  }
}
