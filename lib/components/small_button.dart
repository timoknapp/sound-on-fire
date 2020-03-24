import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  final String text;
  final Function onClick;
  final Icon icon;
  final bool autoFocus;

  const SmallButton({
    this.text,
    this.onClick,
    this.icon,
    this.autoFocus,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 30,
      minWidth: 45,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: FlatButton(
        child: icon != null ? icon : Text(text),
        onPressed: onClick,
        autofocus: autoFocus,
      ),
    );
  }
}
