import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  final String text;
  final void Function() onClick;
  final Icon? icon;
  final bool autoFocus;
  final bool border;

  const SmallButton({
    this.text = "",
    required this.onClick,
    this.icon,
    this.autoFocus = false,
    this.border = false,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: TextButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size?>(Size(40, 35)),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey[100]!),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.grey[800]!),
          overlayColor: MaterialStateProperty.all<Color>(Colors.grey[300]!),
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 5)),
          shape: border
              ? MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.grey[300]!,
                      width: 1,
                      style: BorderStyle.solid
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                )
              : null,
        ),
        child: icon ?? Text(text),
        onPressed: onClick,
        autofocus: autoFocus,
      ),
    );
  }
}
