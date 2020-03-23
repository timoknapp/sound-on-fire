import 'package:flutter/material.dart';

class HeaderBar extends StatelessWidget {
  final Function searchCallback;
  final Function queryCallback;
  final String inputText;

  HeaderBar({
    this.searchCallback,
    this.queryCallback,
    this.inputText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Text(inputText),
          ),
          FlatButton(
            onPressed: searchCallback,
            child: Text(
              'Search',
            ),
          ),
        ],
      ),
    );
  }
}
