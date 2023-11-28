import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:tic_tac_game/functions/button_sound.dart';
import 'package:tic_tac_game/provider/provider_info.dart';
import 'package:tic_tac_game/functions/snacbar_bottom.dart';

import 'alertCup.dart';

CountDownController controller = CountDownController();

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
          if (Provider.of<MyProvider>(context, listen: false).playerPoint1 ==
              2) {
            alertSilver(context);
          } else if (Provider.of<MyProvider>(context, listen: false)
                  .playerPoint1 ==
              3) {
            alertGold(context);
          } else if (Provider.of<MyProvider>(context, listen: false)
                  .playerPoint1 ==
              6) {
            alertPlatinium(context);
          } else if (Provider.of<MyProvider>(context, listen: false)
                  .playerPoint1 ==
              9) {
            alertDiamond(context);
          }

          Provider.of<MyProvider>(context, listen: false).colorX =
              Colors.green.withOpacity(0.5);
          Provider.of<MyProvider>(context, listen: false).playerPoint1 += 1;
          Provider.of<MyProvider>(context, listen: false).countdownStart =
              false;
          showMessage(
              "Player ${Provider.of<MyProvider>(context, listen: false).defaultName} won",
              context);
        } else if (playerPosition0 == "O") {
          Provider.of<MyProvider>(context, listen: false).colorO =
              Colors.red.withOpacity(0.5);
          showMessage(
              "Player ${Provider.of<MyProvider>(context, listen: false).player2} won",
              context);

          Provider.of<MyProvider>(context, listen: false).playerPoint2 += 1;
        }
        buttonWin();
        Provider.of<MyProvider>(context, listen: false).confettiContanier =
            true;

        Provider.of<MyProvider>(context, listen: false).gameEnd = true;

        Provider.of<MyProvider>(context, listen: false).timer = true;
        Provider.of<MyProvider>(context, listen: false).currentPlayer =
            "end game";

        return;
      }
    }
  }
}
