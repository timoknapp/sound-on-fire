import 'package:flutter/material.dart';

class AutocompleteItem extends StatelessWidget {
  final String text;
  final Function onClick;

  const AutocompleteItem({Key key, this.text, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(text),
        onTap: onClick,
      ),
    );
  }

}