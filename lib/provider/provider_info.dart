import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class MyProvider extends ChangeNotifier {
  var data = DateFormat.yMMMEd().format(DateTime.now());
  var hours = DateTime.now();
  String userId = "";
  String status = "bronze";
  bool countdownStart = true;
  Color colorX = Colors.green;
  Color colorO = Colors.red;
  bool timer = false;
  bool confettiContanier = false;
  final int duration = 30;
  int playerPoint1 = 0;
  int playerPoint2 = 0;
  Color color = const Color.fromRGBO(255, 179, 50, 1);
  int colorgradient = 100;
  bool design = false;
  String xturn = 'X';
  String oturn = 'O';
  bool invisibleContainerInfo = false;
  String containerInfoDefault = "";
  String containerInfoText = "Please enter player name";
  String playerX = "X";
  String playerO = "O";
  String player1 = "";
  String player2 = "";
  String defaultName = "";
  String defaultEmail = "";
  String defaultName1 = "";
  late String currentPlayer;
  late bool gameEnd;
  late bool blockButton = false;
  bool invisible = false;
  bool invisibleName = false;
  bool invisibleButtonSave = false;
  late List<String> occupied;
  double borderRadius = 0;
  bool isLoggedIn = false;

  checkUser() {
    String id = FirebaseAuth.instance.currentUser!.uid;
    return id;
  }

  void isLogged() {
    
    isLoggedIn = true;
    notifyListeners();
  }



}
