import 'package:flutter/material.dart';
import 'package:sound_on_fire/components/small_button.dart';

class Keyboard extends StatelessWidget {
  final Function(String) onKeyboardAction;

  Keyboard({
    @required this.onKeyboardAction,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SmallButton(
                text: "A",
                onClick: () => this.onKeyboardAction("a"),
                autoFocus: true,
              ),
              SmallButton(
                text: "B",
                onClick: () => this.onKeyboardAction("b"),
                autoFocus: false,
              ),
              SmallButton(
                text: "C",
                onClick: () => this.onKeyboardAction("c"),
                autoFocus: false,
              ),
              SmallButton(
                text: "D",
                onClick: () => this.onKeyboardAction("d"),
                autoFocus: false,
              ),
              SmallButton(
                text: "E",
                onClick: () => this.onKeyboardAction("e"),
                autoFocus: false,
              ),
              SmallButton(
                text: "F",
                onClick: () => this.onKeyboardAction("f"),
                autoFocus: false,
              ),
              SmallButton(
                text: "G",
                onClick: () => this.onKeyboardAction("g"),
                autoFocus: false,
              ),
              SmallButton(
                text: "BACK",
                icon: Icon(Icons.backspace),
                onClick: () => this.onKeyboardAction("BACK"),
                autoFocus: false,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              SmallButton(
                text: "H",
                onClick: () => this.onKeyboardAction("h"),
                autoFocus: false,
              ),
              SmallButton(
                text: "I",
                onClick: () => this.onKeyboardAction("i"),
                autoFocus: false,
              ),
              SmallButton(
                text: "J",
                onClick: () => this.onKeyboardAction("j"),
                autoFocus: false,
              ),
              SmallButton(
                text: "K",
                onClick: () => this.onKeyboardAction("k"),
                autoFocus: false,
              ),
              SmallButton(
                text: "L",
                onClick: () => this.onKeyboardAction("l"),
                autoFocus: false,
              ),
              SmallButton(
                text: "M",
                onClick: () => this.onKeyboardAction("m"),
                autoFocus: false,
              ),
              SmallButton(
                text: "N",
                onClick: () => this.onKeyboardAction("n"),
                autoFocus: false,
              ),
              SmallButton(
                text: "CLEAR",
                onClick: () => this.onKeyboardAction("CLEAR"),
                autoFocus: false,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              SmallButton(
                text: "O",
                onClick: () => this.onKeyboardAction("o"),
                autoFocus: false,
              ),
              SmallButton(
                text: "P",
                onClick: () => this.onKeyboardAction("P"),
                autoFocus: false,
              ),
              SmallButton(
                text: "Q",
                onClick: () => this.onKeyboardAction("q"),
                autoFocus: false,
              ),
              SmallButton(
                text: "R",
                onClick: () => this.onKeyboardAction("r"),
                autoFocus: false,
              ),
              SmallButton(
                text: "S",
                onClick: () => this.onKeyboardAction("s"),
                autoFocus: false,
              ),
              SmallButton(
                text: "T",
                onClick: () => this.onKeyboardAction("t"),
                autoFocus: false,
              ),
              SmallButton(
                text: "U",
                onClick: () => this.onKeyboardAction("u"),
                autoFocus: false,
              ),
              SmallButton(
                text: "SPACE",
                onClick: () => this.onKeyboardAction(" "),
                autoFocus: false,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              SmallButton(
                text: "V",
                onClick: () => this.onKeyboardAction("v"),
                autoFocus: false,
              ),
              SmallButton(
                text: "W",
                onClick: () => this.onKeyboardAction("w"),
                autoFocus: false,
              ),
              SmallButton(
                text: "X",
                onClick: () => this.onKeyboardAction("x"),
                autoFocus: false,
              ),
              SmallButton(
                text: "Y",
                onClick: () => this.onKeyboardAction("y"),
                autoFocus: false,
              ),
              SmallButton(
                text: "Z",
                onClick: () => this.onKeyboardAction("z"),
                autoFocus: false,
              ),
              SmallButton(
                text: "-",
                onClick: () => this.onKeyboardAction("-"),
                autoFocus: false,
              ),
              SmallButton(
                text: "0",
                onClick: () => this.onKeyboardAction("0"),
                autoFocus: false,
              ),
              SmallButton(
                text: "1",
                onClick: () => this.onKeyboardAction("1"),
                autoFocus: false,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              SmallButton(
                text: "2",
                onClick: () => this.onKeyboardAction("2"),
                autoFocus: false,
              ),
              SmallButton(
                text: "3",
                onClick: () => this.onKeyboardAction("3"),
                autoFocus: false,
              ),
              SmallButton(
                text: "4",
                onClick: () => this.onKeyboardAction("4"),
                autoFocus: false,
              ),
              SmallButton(
                text: "5",
                onClick: () => this.onKeyboardAction("5"),
                autoFocus: false,
              ),
              SmallButton(
                text: "6",
                onClick: () => this.onKeyboardAction("6"),
                autoFocus: false,
              ),
              SmallButton(
                text: "7",
                onClick: () => this.onKeyboardAction("7"),
                autoFocus: false,
              ),
              SmallButton(
                text: "8",
                onClick: () => this.onKeyboardAction("8"),
                autoFocus: false,
              ),
              SmallButton(
                text: "9",
                onClick: () => this.onKeyboardAction("9"),
                autoFocus: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
