import 'package:flutter/material.dart';
import 'package:tic_tac_game/button_style.dart';
import 'package:tic_tac_game/constants/text_style.dart';
import 'package:tic_tac_game/screens/confetti_win.dart';

class PlayerInfoWIdget extends StatelessWidget {
  final String name;
  final String defaultName;
  final String playerPoint1;
  final Function onTap;
  final String action;
  final bool checkConfetti;

  const PlayerInfoWIdget(
      {super.key,
      required this.name,
      required this.defaultName,
      required this.playerPoint1,
      required this.checkConfetti,
      required this.onTap,
      required this.action});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          style: textStyle8,
        ),
        Text(defaultName, style: textStyle2),
        Text(playerPoint1),
        ElevatedButton(
            style: ButtonStylee.ssss,
            onPressed: () {
              onTap();
            },
            child: Text(action)),
        const SizedBox(
          height: 30,
        ),
        checkConfetti == false
            ? const Text("")
            : Container(
                height: 1,
                width: 1,
                color: Colors.yellow,
                child: const winConfetti(),
              ),
      ],
    );
  }
}
