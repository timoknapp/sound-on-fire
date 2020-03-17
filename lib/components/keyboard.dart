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
              new FlatButton(
                child: new Text("A"),
                onPressed: () => this.onKeyboardAction("a"),
                autofocus: true,
              ),
              new FlatButton(
                child: new Text("B"),
                onPressed: () => this.onKeyboardAction("b"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("C"),
                onPressed: () => this.onKeyboardAction("c"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("D"),
                onPressed: () => this.onKeyboardAction("d"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("E"),
                onPressed: () => this.onKeyboardAction("e"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("F"),
                onPressed: () => this.onKeyboardAction("f"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("G"),
                onPressed: () => this.onKeyboardAction("g"),
                autofocus: false,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              new FlatButton(
                child: new Text("H"),
                onPressed: () => this.onKeyboardAction("h"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("I"),
                onPressed: () => this.onKeyboardAction("i"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("J"),
                onPressed: () => this.onKeyboardAction("j"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("K"),
                onPressed: () => this.onKeyboardAction("k"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("L"),
                onPressed: () => this.onKeyboardAction("l"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("M"),
                onPressed: () => this.onKeyboardAction("m"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("N"),
                onPressed: () => this.onKeyboardAction("n"),
                autofocus: false,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              new FlatButton(
                child: new Text("O"),
                onPressed: () => this.onKeyboardAction("o"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("P"),
                onPressed: () => this.onKeyboardAction("p"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("Q"),
                onPressed: () => this.onKeyboardAction("q"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("R"),
                onPressed: () => this.onKeyboardAction("r"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("S"),
                onPressed: () => this.onKeyboardAction("s"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("T"),
                onPressed: () => this.onKeyboardAction("t"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("U"),
                onPressed: () => this.onKeyboardAction("u"),
                autofocus: false,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              new FlatButton(
                child: new Text("V"),
                onPressed: () => this.onKeyboardAction("v"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("W"),
                onPressed: () => this.onKeyboardAction("w"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("X"),
                onPressed: () => this.onKeyboardAction("x"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("Y"),
                onPressed: () => this.onKeyboardAction("y"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("Z"),
                onPressed: () => this.onKeyboardAction("z"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("SPACE"),
                onPressed: () => this.onKeyboardAction(" "),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("BACK"),
                onPressed: () => this.onKeyboardAction("BACK"),
                autofocus: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
