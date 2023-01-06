import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:tic_tac_game/functions/button_sound.dart';
import 'package:tic_tac_game/provider/provider_info.dart';
import 'package:tic_tac_game/functions/snacbar_bottom.dart';
import 'package:tic_tac_game/screens/confetti_win.dart';

late CountDownController controller = CountDownController();

void checkWinner(BuildContext context) {
  List<List<int>> winninglist = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  for (var winningPos in winninglist) {
    print(winningPos);
    String playerPosition0 =
        Provider.of<MyProvider>(context, listen: false).occupied[winningPos[0]];
    String playerPosition1 =
        Provider.of<MyProvider>(context, listen: false).occupied[winningPos[1]];
    String playerPosition2 =
        Provider.of<MyProvider>(context, listen: false).occupied[winningPos[2]];
    if (playerPosition0.isNotEmpty) {
      if (playerPosition0 == playerPosition1 &&
          playerPosition0 == playerPosition2) {
        if (playerPosition0 == "X") {
          Provider.of<MyProvider>(context, listen: false).playerPoint1 += 1;
          showMessage(
              "Player ${Provider.of<MyProvider>(context, listen: false).defaultName} won",
              context);
        } else if (playerPosition0 == "O") {
          showMessage(
              "Player ${Provider.of<MyProvider>(context, listen: false).player2} won",
              context);

          Provider.of<MyProvider>(context, listen: false).playerPoint2 += 1;
        }
        buttonWin();
        Provider.of<MyProvider>(context, listen: false).confettiContanier =
            true;

        //Provider.of<MyProvider>(context, listen: false).invisible = false;
        //Provider.of<MyProvider>(context, listen: false).player2 = "";
        Provider.of<MyProvider>(context, listen: false).gameEnd = true;
        //bax buna///////////////////////////////////////////////
        Provider.of<MyProvider>(context, listen: false).timer = true;
        Provider.of<MyProvider>(context, listen: false).currentPlayer =
            "end game";
        //Provider.of<MyProvider>(context, listen: false).defaultName = "win";
        //Provider.of<MyProvider>(context, listen: false).playerO = "";
        //Provider.of<MyProvider>(context, listen: false).playerX = "";
        // Provider.of<MyProvider>(context, listen: false).invisibleButtonSave = false;

        return;
        // } else if (playerPosition0.isNotEmpty &&
        //     playerPosition1.isNotEmpty &&
        //     playerPosition2.isNotEmpty) {
        //   if (playerPosition0 != playerPosition1 &&
        //       playerPosition0 != playerPosition2 &&
        //       playerPosition2 != playerPosition1) {
        //     print("get tullan");
        //   }
      }
    }
  }
}
