import 'package:flutter/material.dart';

AppBar appBar = AppBar(
  flexibleSpace: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Colors.red, Colors.blue]),
    ),
  ),
  elevation: 0,
  title: const Text(
    "tic-tac game",
    style: TextStyle(color: Colors.black),
  ),
);

AppBar appBarPoint = AppBar(
  flexibleSpace: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Colors.red, Colors.blue]),
    ),
  ),
  elevation: 0,
  title: const Text(
    "Players Point",
    style: TextStyle(color: Colors.black),
  ),
);
