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
                onPressed: () => this.onKeyboardAction("A"),
                autofocus: true,
              ),
              new FlatButton(
                child: new Text("B"),
                onPressed: () => this.onKeyboardAction("B"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("C"),
                onPressed: () => this.onKeyboardAction("C"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("D"),
                onPressed: () => this.onKeyboardAction("D"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("E"),
                onPressed: () => this.onKeyboardAction("E"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("F"),
                onPressed: () => this.onKeyboardAction("F"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("G"),
                onPressed: () => this.onKeyboardAction("G"),
                autofocus: false,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              new FlatButton(
                child: new Text("H"),
                onPressed: () => this.onKeyboardAction("H"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("I"),
                onPressed: () => this.onKeyboardAction("I"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("J"),
                onPressed: () => this.onKeyboardAction("J"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("K"),
                onPressed: () => this.onKeyboardAction("K"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("L"),
                onPressed: () => this.onKeyboardAction("L"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("M"),
                onPressed: () => this.onKeyboardAction("M"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("N"),
                onPressed: () => this.onKeyboardAction("N"),
                autofocus: false,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              new FlatButton(
                child: new Text("O"),
                onPressed: () => this.onKeyboardAction("O"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("P"),
                onPressed: () => this.onKeyboardAction("P"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("Q"),
                onPressed: () => this.onKeyboardAction("Q"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("R"),
                onPressed: () => this.onKeyboardAction("R"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("S"),
                onPressed: () => this.onKeyboardAction("S"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("T"),
                onPressed: () => this.onKeyboardAction("T"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("U"),
                onPressed: () => this.onKeyboardAction("U"),
                autofocus: false,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              new FlatButton(
                child: new Text("V"),
                onPressed: () => this.onKeyboardAction("V"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("W"),
                onPressed: () => this.onKeyboardAction("W"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("X"),
                onPressed: () => this.onKeyboardAction("X"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("Y"),
                onPressed: () => this.onKeyboardAction("Y"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("Z"),
                onPressed: () => this.onKeyboardAction("Z"),
                autofocus: false,
              ),
              new FlatButton(
                child: new Text("SPACE"),
                onPressed: () => this.onKeyboardAction("SPACE"),
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
