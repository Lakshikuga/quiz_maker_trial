import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 22),
      children: <TextSpan>[
        TextSpan(
            text: 'Quiz',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            )),
        TextSpan(
            text: 'Maker',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.blue,
            )),
      ],
    ),
  );
}

//for the blue button.
Widget blueButton({BuildContext context, String label, buttonWidth}) {
  return Container(
    padding: EdgeInsets.symmetric(
      vertical: 18,
    ),
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(30),
    ),
    width: buttonWidth != null ? buttonWidth : MediaQuery.of(context).size.width - 48,
    alignment: Alignment.center,
    child: Text(label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        )),
  );
}
