import 'package:flutter/material.dart';
import 'package:sound_on_fire/util/constants.dart';

class SmallButton extends StatelessWidget {
  final String text;
  final Function onClick;
  final Icon icon;
  final bool autoFocus;
  final bool border;

  const SmallButton({
    this.text,
    this.onClick,
    this.icon,
    this.autoFocus = false,
    this.border = false,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 35,
      minWidth: 40,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: FlatButton(
        shape: border
            ? RoundedRectangleBorder(
                side: BorderSide(
                    color: Colors.grey[300],
                    width: 1,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10),
              )
            : null,
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: icon != null ? icon : Text(text),
        onPressed: onClick,
        autofocus: autoFocus,
      ),
    );
  }
}
