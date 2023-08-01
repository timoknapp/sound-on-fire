import 'package:flutter/material.dart';
import 'package:sound_on_fire/util/constants.dart';

class AutocompleteItem extends StatelessWidget {
  final String text;
  final void Function() onClick;

  const AutocompleteItem({required Key key, required this.text, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: lighterGrey,
      child: ListTile(
        title: Text(text),
        onTap: onClick,
      ),
    );
  }
}
