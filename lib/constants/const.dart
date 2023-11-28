import 'package:flutter/material.dart';

InputDecoration decor1 = InputDecoration(
  hintText: "player1",
  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
);

InputDecoration decor2 = InputDecoration(
  hintText: "rəqibin adını daxil edin",
  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
);

BoxDecoration boxDecoration = const BoxDecoration(
    gradient: LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [
    Colors.blue,
    Colors.red,
  ],
));

BoxDecoration boxDecoration2 = const BoxDecoration(
    gradient: LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [
    Colors.green,
    Colors.yellow,
    Colors.red,
    Colors.blue,
  ],
));

BoxDecoration showAlertDecor =
    BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(50));
