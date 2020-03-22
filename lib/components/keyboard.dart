import 'package:flutter/material.dart';

class Keyboard extends StatelessWidget {
  final Function(String) onKeyboardAction;

  Keyboard({
    @required this.onKeyboardAction,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Row>[
          Row(
            children: <Widget>[
              KeyboardButton(
                text: "A",
                onClick: () => this.onKeyboardAction("a"),
                autoFocus: true,
              ),
              KeyboardButton(
                text: "B",
                onClick: () => this.onKeyboardAction("b"),
                autoFocus: false,
              ),
              KeyboardButton(
                text: "C",
                onClick: () => this.onKeyboardAction("c"),
                autoFocus: false,
              ),
              KeyboardButton(
                text: "D",
                onClick: () => this.onKeyboardAction("d"),
                autoFocus: false,
              ),
              KeyboardButton(
                text: "E",
                onClick: () => this.onKeyboardAction("e"),
                autoFocus: false,
              ),
              KeyboardButton(
                text: "F",
                onClick: () => this.onKeyboardAction("f"),
                autoFocus: false,
              ),
              KeyboardButton(
                text: "G",
                onClick: () => this.onKeyboardAction("g"),
                autoFocus: false,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              KeyboardButton(
                text: "H",
                onClick: () => this.onKeyboardAction("h"),
                autoFocus: false,
              ),
              KeyboardButton(
                text: "I",
                onClick: () => this.onKeyboardAction("i"),
                autoFocus: false,
              ),
              KeyboardButton(
                text: "J",
                onClick: () => this.onKeyboardAction("j"),
                autoFocus: false,
              ),
              KeyboardButton(
                text: "K",
                onClick: () => this.onKeyboardAction("k"),
                autoFocus: false,
              ),
              KeyboardButton(
                text: "L",
                onClick: () => this.onKeyboardAction("l"),
                autoFocus: false,
              ),
              KeyboardButton(
                text: "M",
                onClick: () => this.onKeyboardAction("m"),
                autoFocus: false,
              ),
              KeyboardButton(
                text: "N",
                onClick: () => this.onKeyboardAction("n"),
                autoFocus: false,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              KeyboardButton(
                text: "O",
                onClick: () => this.onKeyboardAction("o"),
                autoFocus: false,
              ),
              KeyboardButton(
                text: "P",
                onClick: () => this.onKeyboardAction("P"),
                autoFocus: false,
              ),
              KeyboardButton(
                text: "Q",
                onClick: () => this.onKeyboardAction("q"),
                autoFocus: false,
              ),
              KeyboardButton(
                text: "R",
                onClick: () => this.onKeyboardAction("r"),
                autoFocus: false,
              ),
              KeyboardButton(
                text: "S",
                onClick: () => this.onKeyboardAction("s"),
                autoFocus: false,
              ),
              KeyboardButton(
                text: "T",
                onClick: () => this.onKeyboardAction("t"),
                autoFocus: false,
              ),
              KeyboardButton(
                text: "U",
                onClick: () => this.onKeyboardAction("u"),
                autoFocus: false,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              KeyboardButton(
                text: "V",
                onClick: () => this.onKeyboardAction("v"),
                autoFocus: false,
              ),
              KeyboardButton(
                text: "W",
                onClick: () => this.onKeyboardAction("w"),
                autoFocus: false,
              ),
              KeyboardButton(
                text: "X",
                onClick: () => this.onKeyboardAction("x"),
                autoFocus: false,
              ),
              KeyboardButton(
                text: "Y",
                onClick: () => this.onKeyboardAction("y"),
                autoFocus: false,
              ),
              KeyboardButton(
                text: "Z",
                onClick: () => this.onKeyboardAction("z"),
                autoFocus: false,
              ),
              KeyboardButton(
                text: "SPACE",
                onClick: () => this.onKeyboardAction(" "),
                autoFocus: false,
              ),
              KeyboardButton(
                text: "BACK",
                onClick: () => this.onKeyboardAction("BACK"),
                autoFocus: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class KeyboardButton extends StatelessWidget {
  final String text;
  final Function onClick;
  final bool autoFocus;

  const KeyboardButton({
    this.text,
    this.onClick,
    this.autoFocus,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 25,
      minWidth: 40,
      child: FlatButton(
        child: Text(text),
        onPressed: onClick,
        autofocus: autoFocus,
      ),
    );
  }
}
