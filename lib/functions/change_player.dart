import 'package:flutter/material.dart';
import 'package:tic_tac_game/provider/provider_info.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
void changePlayer(BuildContext context) {
    if (Provider.of<MyProvider>(context, listen: false).currentPlayer ==
        Provider.of<MyProvider>(context, listen: false).xturn) {
      Provider.of<MyProvider>(context, listen: false).currentPlayer =
          Provider.of<MyProvider>(context, listen: false).oturn;
    } else {
      Provider.of<MyProvider>(context, listen: false).currentPlayer =
          Provider.of<MyProvider>(context, listen: false).xturn;
    }
  }
