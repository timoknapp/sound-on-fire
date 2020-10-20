import 'package:flutter/material.dart';
import 'package:sound_on_fire/components/small_button.dart';

class Keyboard extends StatelessWidget {
  final Function(String) onKeyboardAction;
  final bool isAlphabeticalKeyboard;

  Keyboard({
    @required this.onKeyboardAction,
    @required this.isAlphabeticalKeyboard,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: isAlphabeticalKeyboard ? getAlphabet() : getNumbers());
  }

  Column getAlphabet() {
    return new Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SmallButton(
              text: "A",
              onClick: () => this.onKeyboardAction("a"),
              autoFocus: true,
              border: true,
            ),
            SmallButton(
              text: "B",
              onClick: () => this.onKeyboardAction("b"),
              border: true,
            ),
            SmallButton(
              text: "C",
              onClick: () => this.onKeyboardAction("c"),
              border: true,
            ),
            SmallButton(
              text: "D",
              onClick: () => this.onKeyboardAction("d"),
              border: true,
            ),
            SmallButton(
              text: "E",
              onClick: () => this.onKeyboardAction("e"),
              border: true,
            ),
            SmallButton(
              text: "F",
              onClick: () => this.onKeyboardAction("f"),
              border: true,
            ),
            SmallButton(
              text: "G",
              onClick: () => this.onKeyboardAction("g"),
              border: true,
            ),
            SmallButton(
              text: "BACK",
              icon: Icon(Icons.backspace),
              onClick: () => this.onKeyboardAction("BACK"),
              border: true,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            SmallButton(
              text: "H",
              onClick: () => this.onKeyboardAction("h"),
              border: true,
            ),
            SmallButton(
              text: "I",
              onClick: () => this.onKeyboardAction("i"),
              border: true,
            ),
            SmallButton(
              text: "J",
              onClick: () => this.onKeyboardAction("j"),
              border: true,
            ),
            SmallButton(
              text: "K",
              onClick: () => this.onKeyboardAction("k"),
              border: true,
            ),
            SmallButton(
              text: "L",
              onClick: () => this.onKeyboardAction("l"),
              border: true,
            ),
            SmallButton(
              text: "M",
              onClick: () => this.onKeyboardAction("m"),
              border: true,
            ),
            SmallButton(
              text: "N",
              onClick: () => this.onKeyboardAction("n"),
              border: true,
            ),
            SmallButton(
              text: "&123",
              onClick: () => this.onKeyboardAction("&123"),
              border: true,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            SmallButton(
              text: "O",
              onClick: () => this.onKeyboardAction("o"),
              border: true,
            ),
            SmallButton(
              text: "P",
              onClick: () => this.onKeyboardAction("P"),
              border: true,
            ),
            SmallButton(
              text: "Q",
              onClick: () => this.onKeyboardAction("q"),
              border: true,
            ),
            SmallButton(
              text: "R",
              onClick: () => this.onKeyboardAction("r"),
              border: true,
            ),
            SmallButton(
              text: "S",
              onClick: () => this.onKeyboardAction("s"),
              border: true,
            ),
            SmallButton(
              text: "T",
              onClick: () => this.onKeyboardAction("t"),
              border: true,
            ),
            SmallButton(
              text: "U",
              onClick: () => this.onKeyboardAction("u"),
              border: true,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            SmallButton(
              text: "V",
              onClick: () => this.onKeyboardAction("v"),
              border: true,
            ),
            SmallButton(
              text: "W",
              onClick: () => this.onKeyboardAction("w"),
              border: true,
            ),
            SmallButton(
              text: "X",
              onClick: () => this.onKeyboardAction("x"),
              border: true,
            ),
            SmallButton(
              text: "Y",
              onClick: () => this.onKeyboardAction("y"),
              border: true,
            ),
            SmallButton(
              text: "Z",
              onClick: () => this.onKeyboardAction("z"),
              border: true,
            ),
            SmallButton(
              text: "-",
              onClick: () => this.onKeyboardAction("-"),
              border: true,
            ),
            SmallButton(
              text: "'",
              onClick: () => this.onKeyboardAction("'"),
              border: true,
            ),
          ],
        ),
        getLastRow(),
      ],
    );
  }

  Column getNumbers() {
    return new Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SmallButton(
              text: "1",
              onClick: () => this.onKeyboardAction("1"),
              border: true,
            ),
            SmallButton(
              text: "2",
              onClick: () => this.onKeyboardAction("2"),
              border: true,
            ),
            SmallButton(
              text: "3",
              onClick: () => this.onKeyboardAction("3"),
              border: true,
            ),
            SmallButton(
              text: "&",
              onClick: () => this.onKeyboardAction("&"),
              border: true,
            ),
            SmallButton(
              text: "#",
              onClick: () => this.onKeyboardAction("#"),
              border: true,
            ),
            SmallButton(
              text: "(",
              onClick: () => this.onKeyboardAction("("),
              border: true,
            ),
            SmallButton(
              text: ")",
              onClick: () => this.onKeyboardAction(")"),
              border: true,
            ),
            SmallButton(
              text: "BACK",
              icon: Icon(Icons.backspace),
              onClick: () => this.onKeyboardAction("BACK"),
              border: true,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            SmallButton(
              text: "4",
              onClick: () => this.onKeyboardAction("4"),
              border: true,
            ),
            SmallButton(
              text: "5",
              onClick: () => this.onKeyboardAction("5"),
              border: true,
            ),
            SmallButton(
              text: "6",
              onClick: () => this.onKeyboardAction("6"),
              border: true,
            ),
            SmallButton(
              text: "@",
              onClick: () => this.onKeyboardAction("@"),
              border: true,
            ),
            SmallButton(
              text: "!",
              onClick: () => this.onKeyboardAction("!"),
              border: true,
            ),
            SmallButton(
              text: "?",
              onClick: () => this.onKeyboardAction("?"),
              border: true,
            ),
            SmallButton(
              text: ":",
              onClick: () => this.onKeyboardAction(":"),
              border: true,
            ),
            SmallButton(
              text: "ABC",
              onClick: () => this.onKeyboardAction("ABC"),
              border: true,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            SmallButton(
              text: "7",
              onClick: () => this.onKeyboardAction("7"),
              border: true,
            ),
            SmallButton(
              text: "8",
              onClick: () => this.onKeyboardAction("8"),
              border: true,
            ),
            SmallButton(
              text: "9",
              onClick: () => this.onKeyboardAction("9"),
              border: true,
            ),
            SmallButton(
              text: "0",
              onClick: () => this.onKeyboardAction("0"),
              border: true,
            ),
            SmallButton(
              text: ".",
              onClick: () => this.onKeyboardAction("."),
              border: true,
            ),
            SmallButton(
              text: "_",
              onClick: () => this.onKeyboardAction("_"),
              border: true,
            ),
            SmallButton(
              text: "\"",
              onClick: () => this.onKeyboardAction("\""),
              border: true,
            ),
          ],
        ),
        getLastRow(),
      ],
    );
  }

  Row getLastRow() {
    return Row(
      children: <Widget>[
        SmallButton(
          text: "             SPACE             ",
          onClick: () => this.onKeyboardAction(" "),
          border: true,
        ),
        SmallButton(
          text: "           CLEAR           ",
          onClick: () => this.onKeyboardAction("CLEAR"),
          border: true,
        ),
      ],
    );
  }
}
