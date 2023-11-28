 import 'package:flutter/material.dart';
import 'package:tic_tac_game/constants/text_style.dart';
import 'package:tic_tac_game/model/game_rules.dart';

void showAlert( context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              content: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Oyunun qaydaları",
                        style: textStyle3,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 500,
                        width: 300,
                        child: ListView.builder(
                            physics: const ScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: GameRulesList.gameRulesList.length,
                            itemBuilder: (BuildContext context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: RichText(
                                  text: TextSpan(
                                    text:
                                        GameRulesList.gameRulesList[index].number,
                                    style: textStyle5,
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: GameRulesList
                                              .gameRulesList[index].text,
                                          style: textStyle4),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "Uğurlar!",
                        style: textStyle3,
                      ),
                    TextButton(
                      child: Text(
                        "Anladım",
                        style: textStyle14,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ));
  }