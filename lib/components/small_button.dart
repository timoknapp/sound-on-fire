import 'package:flutter/material.dart';
import 'package:sound_on_fire/util/constants.dart';

class SmallButton extends StatelessWidget {
  final String text;
  final Function onClick;
  final Icon icon;
  final bool autoFocus;
  final bool border;
  final Color color;

  const SmallButton({
    this.text,
    this.onClick,
    this.icon,
    this.autoFocus = false,
    this.border = false,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return TextButtonTheme(
      data: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: Size(40, 35),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.symmetric(horizontal: 5),
          foregroundColor: color,
          shape: border 
            ? RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey[300],
                  width: 1,
                  style: BorderStyle.solid
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )
            : null,
        ),
      ),
      child: TextButton(
        // style: flatButtonStyle,
        onPressed: onClick,
        autofocus: autoFocus,
        child: icon != null ? icon : Text(text),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return ButtonTheme(
  //     height: 35,
  //     minWidth: 40,
  //     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //     child: FlatButton(
  //       shape: border
  //           ? RoundedRectangleBorder(
  //               side: BorderSide(
  //                 color: Colors.grey[300],
  //                 width: 1,
  //                 style: BorderStyle.solid
  //               ),
  //               borderRadius: BorderRadius.circular(10),
  //             )
  //           : null,
  //       padding: EdgeInsets.symmetric(horizontal: 5),
  //       child: icon != null ? icon : Text(text),
  //       onPressed: onClick,
  //       autofocus: autoFocus,
  //     ),
  //   );
  // }
}
