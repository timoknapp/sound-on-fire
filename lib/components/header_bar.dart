import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HeaderBar extends StatelessWidget {
  final Function searchCallback;
  final Function queryCallback;
  final String inputText;
  // final FocusNode inputFocus;

  HeaderBar({
    this.searchCallback,
    this.queryCallback,
    this.inputText,
    // this.inputFocus,
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
