//define global widgets here such as appbar
import 'package:flutter/material.dart';

Widget NextButtonBig(VoidCallback? onPressed) {
  return Container(
    width: 335,
    height: 48,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        '다음',
        style: FontButtonWhite14,
      ),
      style:
          ElevatedButton.styleFrom(primary: Color.fromARGB(255, 51, 89, 183)),
    ),
  );
}

TextStyle FontButtonWhite14 =
    TextStyle(fontFamily: 'AppleSDGothicNeo', fontWeight: FontWeight.w500 ,fontSize: 14, letterSpacing: 0.1);
