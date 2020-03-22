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
      // child: RawKeyboardListener(
      //   focusNode: inputFocus,
      //   onKey: (RawKeyEvent event) {
      //     if (event is RawKeyDownEvent &&
      //         event.data is RawKeyEventDataAndroid) {
      //       RawKeyDownEvent rawKeyDownEvent = event;
      //       RawKeyEventDataAndroid rawKeyEventDataAndroid =
      //           rawKeyDownEvent.data;
      //       print("tv launcher sample ${rawKeyEventDataAndroid.keyCode}");
      //       switch (rawKeyEventDataAndroid.keyCode) {
      //         case 23:
      //           print("center");
      //           break;
      //         case 19:
      //           // FocusScope.of(context).requestFocus(focusNodes[2]);
      //           print("UP");
      //           break;
      //         case 20:
      //           // FocusScope.of(context).requestFocus(focusNodes[1]);
      //           print("DOWN");
      //           FocusScope.of(context).unfocus();
      //           break;
      //         case 21:
      //           // FocusScope.of(context).requestFocus(focusNodes[1]);
      //           print("LEFT");
      //           break;
      //         case 22:
      //           // FocusScope.of(context).requestFocus(focusNodes[1]);
      //           print("RIGHT");
      //           break;
      //         default:
      //           break;
      //       }
      //     }
      //   },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Text(inputText),
            // child: TextField(
            //   onChanged: queryCallback,
            //   decoration: InputDecoration(
            //     hintText: 'Please enter a search term',
            //     contentPadding: const EdgeInsets.all(20.0),
            //   ),
            //   onEditingComplete: () {
            //     print("edit Complete");
            //     FocusScope.of(context).unfocus();
            //     searchCallback();
            //   },
            //   // focusNode: inputFocus,
            //   controller: TextEditingController(text: inputText),
            //   readOnly: true,
            //   showCursor: true,
            //   // onSubmitted: (text) {
            //   //   print("Submit");
            //   //   FocusScope.of(context).unfocus();
            //   //   searchCallback();
            //   // },
            // ),
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
