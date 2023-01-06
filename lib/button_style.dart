import 'package:flutter/material.dart';

class ButtonStylee {
  static final ssss = ElevatedButton.styleFrom(
      backgroundColor: Colors.purple,
       shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
      //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold));
}

class ButtonStylee1 {
  static final ssss = ElevatedButton.styleFrom(
      backgroundColor: Colors.green,
       shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
}

