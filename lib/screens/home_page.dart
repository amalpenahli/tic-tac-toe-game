import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:tic_tac_game/auth/login.dart';
import 'package:tic_tac_game/button_style.dart';
import 'package:tic_tac_game/constants/const.dart';
import 'package:tic_tac_game/constants/text_style.dart';
import 'package:tic_tac_game/countdown_start.dart';
import 'package:tic_tac_game/functions/button_sound.dart';
import 'package:tic_tac_game/functions/change_player.dart';
import 'package:tic_tac_game/functions/snacbar_bottom.dart';
import 'package:tic_tac_game/model/game_rules.dart';
import 'package:tic_tac_game/screens/appbar.dart';
import 'package:tic_tac_game/screens/confetti_win.dart';
import 'package:tic_tac_game/screens/point_screen.dart';
import 'package:tic_tac_game/screens/splash_screen.dart';

import '../functions/check_winner.dart';
import '../provider/provider_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final User? currentUser;
  late final CollectionReference usersCollection;
  late final CollectionReference playersCollection;

  late final FirebaseAuth _firebaseAuth;
  late final FirebaseFirestore _firestore;

  @override
  void initState() {
    _firestore = FirebaseFirestore.instance;
    _firebaseAuth = FirebaseAuth.instance;
    currentUser = _firebaseAuth.currentUser;
    usersCollection = _firestore.collection('userInfo');
    playersCollection = _firestore.collection('playersInfo');
    initalizeGame();
    Future.delayed(const Duration(seconds: 1), () => showAlert());

    super.initState();
  }

  void initalizeGame() {
    Provider.of<MyProvider>(context, listen: false).currentPlayer =
        Provider.of<MyProvider>(context, listen: false).xturn;
    Provider.of<MyProvider>(context, listen: false).gameEnd = true;
    Provider.of<MyProvider>(context, listen: false).occupied = [
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      ""
    ];
  }

  Widget headerText(int index) {
    return Text(
      "next player: ${Provider.of<MyProvider>(context, listen: false).currentPlayer}",
      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    );
  }

  Widget gameContainer() {
    return Expanded(
      child: SizedBox(
        //height: MediaQuery.of(context).size.height,

        //margin: const EdgeInsets.all(2),
        child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, int index) {
              return box(index);
            }),
      ),
    );
  }

  restartgame() {
    return SizedBox(
     width: MediaQuery.of(context).size.width/2.5,
      child: ElevatedButton(
          style: ButtonStylee.ssss,
          onPressed: () {
            buttonSoundRestart();
            setState(() {
              initalizeGame();
              Provider.of<MyProvider>(context, listen: false)
                  .confettiContanier = false;
              Provider.of<MyProvider>(context, listen: false).player1 = "";
              Provider.of<MyProvider>(context, listen: false).player2 = "";
              Provider.of<MyProvider>(context, listen: false)
                  .invisibleContainerInfo = false;
              Provider.of<MyProvider>(context, listen: false).invisible = false;
              Provider.of<MyProvider>(context, listen: false).invisibleName =
                  false;
              Provider.of<MyProvider>(context, listen: false).invisible = false;
              Provider.of<MyProvider>(context, listen: false)
                  .invisibleButtonSave = false;
              Provider.of<MyProvider>(context, listen: false).playerPoint1 = 0;
              Provider.of<MyProvider>(context, listen: false).playerPoint2 = 0;
            });
          },
          child: const Text("restart", style: TextStyle(fontSize: 20),)),
    );
  }

  playersname() {
    return SizedBox(
      width: MediaQuery.of(context).size.width/2.5,
      child: ElevatedButton(
          style: ButtonStylee.ssss,
          onPressed: Provider.of<MyProvider>(context, listen: false).gameEnd ==
                  false
              ? null
              : () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        title: const Text("Players Name"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              onChanged: (value) {
                                Provider.of<MyProvider>(context, listen: false)
                                    .player2 = value;
                              },
                              decoration: decor2,
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text("oyuna başla"),
                            onPressed: () {
                              setState(() {
                                // buttonStart();
                                // Provider.of<MyProvider>(context, listen: false)
                                //     .invisibleName = true;
                                if (Provider.of<MyProvider>(context,
                                            listen: false)
                                        .player2 ==
                                    "") {
                                  buttonSoundError();
                                  showNotName(context);
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .invisibleName = false;
                                } else {
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .invisibleButtonSave = true;
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .invisibleContainerInfo = true;
                                  initalizeGame();
                                  buttonStart();
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .invisible = true;
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .gameEnd = false;
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .invisibleName = true;
                                  Navigator.of(context).pop();
                                }
                              });
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
          child: const Text("player",style: TextStyle(fontSize: 20),)),
    );
  }

  void showAlert() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Center(
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
                    Text(
                      "Uğurlar!",
                      style: textStyle3,
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    "Anladım",
                    style: textStyle3,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  Widget box(int index) {
    return InkWell(
      onTap: () {
        if (Provider.of<MyProvider>(context, listen: false).gameEnd ||
            Provider.of<MyProvider>(context, listen: false)
                .occupied[index]
                .isNotEmpty) {
          buttonSoundError();
          return;
        } else {
          buttonSound();
        }
        setState(() {
          Provider.of<MyProvider>(context, listen: false).occupied[index] =
              Provider.of<MyProvider>(context, listen: false).currentPlayer;
          changePlayer(context);
          checkWinner(context);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              Provider.of<MyProvider>(context, listen: false).borderRadius),
          color: Provider.of<MyProvider>(context, listen: false)
                  .occupied[index]
                  .isEmpty
              ? Color.fromRGBO(
                  0,
                  Provider.of<MyProvider>(context, listen: false).colorgradient,
                  150,
                  180)
              : Provider.of<MyProvider>(context, listen: false)
                          .occupied[index] ==
                      Provider.of<MyProvider>(context, listen: false).xturn
                  ? Colors.green
                  : Colors.red,
        ),
        margin: const EdgeInsets.all(8),
        child: Center(
          child: Text(
            Provider.of<MyProvider>(context, listen: false).occupied[index],
            style: const TextStyle(fontSize: 50),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: usersCollection.doc(currentUser?.uid).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          Provider.of<MyProvider>(context, listen: false).defaultName =
              data['name'];
          Provider.of<MyProvider>(context, listen: false).defaultEmail =
              data['email'];
          return Scaffold(
              appBar: appBar,
              drawer: Drawer(
                child: Container(
                  decoration: boxDecoration2,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Text(
                        "Player information",
                        style: textStyle9,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Row(
                          children: [
                            Text(
                              "Name: ",
                              style: textStyle4,
                            ),
                            Text(
                              Provider.of<MyProvider>(context, listen: false)
                                  .defaultName,
                              style: textStyle6,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Row(
                          children: [
                            Text(
                              "Email: ",
                              style: textStyle4,
                            ),
                            Text(
                              Provider.of<MyProvider>(context, listen: false)
                                  .defaultEmail,
                              style: textStyle6,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text("Settings", style: textStyle9),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Row(
                          children: [
                            Text(
                              "Change design: ",
                              style: textStyle4,
                            ),
                            Expanded(
                              child: Slider(
                                min: 0,
                                max: 50,
                                value: Provider.of<MyProvider>(context,
                                        listen: false)
                                    .borderRadius,
                                activeColor: Colors.orange,
                                inactiveColor: Colors.blue,
                                onChanged: (value) {
                                  setState(() {
                                    Provider.of<MyProvider>(context,
                                            listen: false)
                                        .borderRadius = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Row(
                          children: [
                            Text(
                              "Change color: ",
                              style: textStyle4,
                            ),
                            Expanded(
                              child: Slider(
                                min: 0,
                                max: 255,
                                value: Provider.of<MyProvider>(context,
                                        listen: false)
                                    .colorgradient
                                    .toDouble(),
                                activeColor: Colors.orange,
                                inactiveColor: Colors.blue,
                                onChanged: (value) {
                                  setState(() {
                                    Provider.of<MyProvider>(context,
                                            listen: false)
                                        .colorgradient = value.toInt();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                          icon: const Icon(
                            Icons.exit_to_app,
                            size: 40,
                          )),
                      
                    ],
                  ),
                ),
              ),
              body: Container(
                decoration: boxDecoration,
                child: Center(
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(children: [
                        Container(
                          decoration: boxDecoration1,
                          height: MediaQuery.of(context).size.height / 3.47,
                          width: MediaQuery.of(context).size.width / 1.02,
                          child: Provider.of<MyProvider>(context, listen: false)
                                      .invisibleContainerInfo ==
                                  true
                              ? Row(
                                  children: [
                                    Provider.of<MyProvider>(
                                                    context,
                                                    listen: false)
                                                .invisible ==
                                            true
                                        ? Container(
                                            width:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3.2,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4,
                                            color: Colors.transparent,
                                            child: const CountdownStart())
                                        : const Text(""),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30.0),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        child: Column(
                                          children: [
                                            Text(
                                              Provider.of<MyProvider>(context,
                                                              listen: false)
                                                          .invisibleName ==
                                                      true
                                                  ? Provider.of<MyProvider>(
                                                          context,
                                                          listen: false)
                                                      .playerX
                                                  : Provider.of<MyProvider>(
                                                          context,
                                                          listen: false)
                                                      .defaultName1,
                                              style: textStyle8,
                                            ),
                                            Text(
                                                Provider.of<MyProvider>(context,
                                                                listen: false)
                                                            .invisibleName ==
                                                        true
                                                    ? Provider.of<MyProvider>(
                                                            context,
                                                            listen: false)
                                                        .defaultName
                                                    : Provider.of<MyProvider>(
                                                            context,
                                                            listen: false)
                                                        .defaultName1,
                                                style: textStyle2),
                                            Text(Provider.of<MyProvider>(
                                                    context,
                                                    listen: false)
                                                .playerPoint1
                                                .toString()),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            Provider.of<MyProvider>(context,
                                                            listen: false)
                                                        .invisibleButtonSave ==
                                                    true
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 40.0),
                                                    child: ElevatedButton(
                                                        style:
                                                            ButtonStylee.ssss,
                                                        onPressed: () {
                                                          buttonSave();
                                                          setState(() {
                                                            createInfo();
                                                            // Provider.of<MyProvider>(
                                                            //         context,
                                                            //         listen: false)
                                                            //     .defaultName = "";
                                                            // Provider.of<MyProvider>(
                                                            //         context,
                                                            //         listen: false)
                                                            //     .playerO = "";
                                                            // Provider.of<MyProvider>(
                                                            //         context,
                                                            //         listen: false)
                                                            //     .playerX = "";
                                                            // Provider.of<MyProvider>(
                                                            //         context,
                                                            //         listen: false)
                                                            //     .invisible = false;
                                                            // Provider.of<MyProvider>(
                                                            //         context,
                                                            //         listen: false)
                                                            //     .player2 = "";
                                                            //     Provider.of<MyProvider>(
                                                            //         context,
                                                            //         listen: false)
                                                            //     .invisibleButtonSave =false;
                                                          });
                                                        },
                                                        child: const Text(
                                                            "save data")),
                                                  )
                                                : const Text(""),
                                            Provider.of<MyProvider>(context,
                                                            listen: false)
                                                        .confettiContanier ==
                                                    false
                                                ? const Text("")
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 40.0),
                                                    child: Container(
                                                      height: 1,
                                                      width: 1,
                                                      color: Colors.yellow,
                                                      child:
                                                          const winConfetti(),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        child: Column(
                                          children: [
                                            Text(
                                              Provider.of<MyProvider>(context,
                                                              listen: false)
                                                          .invisibleName ==
                                                      true
                                                  ? Provider.of<MyProvider>(
                                                          context,
                                                          listen: false)
                                                      .playerO
                                                  : Provider.of<MyProvider>(
                                                          context,
                                                          listen: false)
                                                      .defaultName1,
                                              style: textStyle8,
                                            ),
                                            Text(
                                                Provider.of<MyProvider>(context,
                                                        listen: false)
                                                    .player2,
                                                style: textStyle2),
                                            Text(Provider.of<MyProvider>(
                                                    context,
                                                    listen: false)
                                                .playerPoint2
                                                .toString()),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Center(
                                  child: Text(
                                  Provider.of<MyProvider>(context,
                                                  listen: false)
                                              .invisibleContainerInfo ==
                                          false
                                      ? Provider.of<MyProvider>(context,
                                              listen: false)
                                          .containerInfoText
                                      : Provider.of<MyProvider>(context,
                                              listen: false)
                                          .containerInfoDefault,
                                  style: textStyle10,
                                )),
                        ),
                      ]),
                      headerText(0),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [restartgame(), playersname()],
                        ),
                      ),
                      gameContainer(),
                    ],
                  ),
                ),
              ));
        });
  }

  createInfo() {
    DocumentReference documentReference = playersCollection.doc();

    Map<String, String> info = {
      "player1Name":
          Provider.of<MyProvider>(context, listen: false).defaultName,
      "player2Name": Provider.of<MyProvider>(context, listen: false).player2,
      "player1Point": Provider.of<MyProvider>(context, listen: false)
          .playerPoint1
          .toString(),
      "player2Point": Provider.of<MyProvider>(context, listen: false)
          .playerPoint2
          .toString(),
      "userId": currentUser!.uid
    };
    documentReference.set(info).whenComplete(() => {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const PointScreen())),
        });
  }
}
