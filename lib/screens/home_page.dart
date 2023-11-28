import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_game/auth/login.dart';
import 'package:tic_tac_game/button_style.dart';
import 'package:tic_tac_game/constants/const.dart';
import 'package:tic_tac_game/constants/text_style.dart';
import 'package:tic_tac_game/countdown_start.dart';

import 'package:tic_tac_game/functions/button_sound.dart';
import 'package:tic_tac_game/functions/change_player.dart';
import 'package:tic_tac_game/functions/check_winner.dart';

import 'package:tic_tac_game/functions/initilgame.dart';
import 'package:tic_tac_game/functions/show_alert.dart';
import 'package:tic_tac_game/functions/snacbar_bottom.dart';
import 'package:tic_tac_game/screens/appbar.dart';

import 'package:tic_tac_game/screens/point_screen.dart';

import 'package:tic_tac_game/widget/player_info_widget.dart';

import '../provider/provider_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final User currentUser;
  late final CollectionReference usersCollection;
  late final CollectionReference playersCollection;
  late final CollectionReference pointCollection;
  late final FirebaseAuth _firebaseAuth;
  late final FirebaseFirestore _firestore;

  var text = "amal";

  @override
  void initState() {
    _firestore = FirebaseFirestore.instance;
    _firebaseAuth = FirebaseAuth.instance;
    currentUser = _firebaseAuth.currentUser!;
    usersCollection = _firestore.collection('userInfo');
    pointCollection = _firestore.collection("pointInfo");
    playersCollection = _firestore.collection('playersInfo');
    initalizeGame();
    Future.delayed(const Duration(seconds: 1), () => showAlert(context));

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
                  ? Provider.of<MyProvider>(context, listen: false).colorX
                  : Provider.of<MyProvider>(context, listen: false).colorO,
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

  Widget gameContainer() {
    return Expanded(
      child: SizedBox(
        //height: MediaQuery.of(context).size.height,

        //margin: const EdgeInsets.all(2),
        child: GridView.builder(
            // physics: const NeverScrollableScrollPhysics(),
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, int index) {
              return box(index);
            }),
      ),
    );
  }

  Widget headerText(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("next player  : ", style: font1),
        const SizedBox(
          width: 10,
        ),
        Text(Provider.of<MyProvider>(context, listen: false).currentPlayer,
            style: font1)
      ],
    );
  }

  restartgame() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.5,
      child: ElevatedButton(
          style: ButtonStylee.ssss,
          onPressed: () {
            buttonSoundRestart();
            setState(() {
              initalizeGame();

              initGame(context);
            });
          },
          child: const Text(
            "restart",
            style: TextStyle(fontSize: 20),
          )),
    );
  }

  playersname() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.5,
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
                                Provider.of<MyProvider>(context, listen: false)
                                    .playerPoint1 = 0;
                                showStart(context);
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
          child: const Text(
            "player",
            style: TextStyle(fontSize: 20),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: usersCollection.doc(currentUser.uid).snapshots(),
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
              appBar: appBar(context),
              drawer: Drawer(
                child: Container(
                  decoration: boxDecoration2,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Provider.of<MyProvider>(context, listen: false)
                                            .playerPoint1 <=
                                        2
                                    ? Text(
                                        Provider.of<MyProvider>(context,
                                                listen: false)
                                            .status,
                                        style: textStylebronze,
                                      )
                                    : Provider.of<MyProvider>(context, listen: false).playerPoint1 > 2 &&
                                            Provider.of<MyProvider>(context, listen: false)
                                                    .playerPoint1 <
                                                4
                                        ? Text(
                                            Provider.of<MyProvider>(context,
                                                    listen: false)
                                                .status = "silver",
                                            style: textStylesilver,
                                          )
                                        : Provider.of<MyProvider>(context, listen: false)
                                                        .playerPoint1 >=
                                                    4 &&
                                                Provider.of<MyProvider>(context,
                                                            listen: false)
                                                        .playerPoint1 <=
                                                    6
                                            ? Text(
                                                Provider.of<MyProvider>(context,
                                                        listen: false)
                                                    .status = "gold",
                                                style: textStylegold,
                                              )
                                            : Provider.of<MyProvider>(context,
                                                                listen: false)
                                                            .playerPoint1 >=
                                                        7 &&
                                                    Provider.of<MyProvider>(context, listen: false).playerPoint1 <= 9
                                                ? Text(
                                                    Provider.of<MyProvider>(
                                                            context,
                                                            listen: false)
                                                        .status = "platinium",
                                                    style: textStyleplatinium,
                                                  )
                                                : Text(
                                                    Provider.of<MyProvider>(
                                                            context,
                                                            listen: false)
                                                        .status = "diamond",
                                                    style: textStylediamond,
                                                  ),
                                Text(
                                  " account ",
                                  style: textStyle13,
                                ),
                              ]),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
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
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PointScreen()),
                            );
                          },
                          child: const Text("Go to point page")),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text("Exit", style: textStyle10),
                          ),
                          IconButton(
                              onPressed: () async {
                                SharedPreferences pref =
                                    await SharedPreferences.getInstance();
                                pref.remove('email');
                                setState(() {
                                  initalizeGame();
                                  initGame(context);

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()));
                                });
                              },
                              icon: const Icon(
                                Icons.exit_to_app,
                                size: 40,
                              )),
                        ],
                      ),
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
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(
                                Provider.of<MyProvider>(context, listen: false)
                                    .borderRadius,
                              )),
                          height: MediaQuery.of(context).size.height / 3.7,
                          width: MediaQuery.of(context).size.width,
                          child: Provider.of<MyProvider>(context, listen: false)
                                      .invisibleContainerInfo ==
                                  true
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Provider.of<MyProvider>(context,
                                                    listen: false)
                                                .invisible ==
                                            true
                                        ? const CountdownStart()
                                        : const Text(""),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            top: 30.0, left: 10),
                                        child: PlayerInfoWIdget(
                                          name: Provider.of<MyProvider>(context,
                                                          listen: false)
                                                      .invisibleName ==
                                                  true
                                              ? Provider.of<MyProvider>(context,
                                                      listen: false)
                                                  .playerX
                                              : Provider.of<MyProvider>(context,
                                                      listen: false)
                                                  .defaultName1,
                                          defaultName: Provider.of<MyProvider>(
                                                          context,
                                                          listen: false)
                                                      .invisibleName ==
                                                  true
                                              ? Provider.of<MyProvider>(context,
                                                      listen: false)
                                                  .defaultName
                                              : Provider.of<MyProvider>(context,
                                                      listen: false)
                                                  .defaultName1,
                                          playerPoint1: Provider.of<MyProvider>(
                                                  context,
                                                  listen: false)
                                              .playerPoint1
                                              .toString(),
                                          onTap: () {
                                            buttonSave();
                                            setState(() {
                                              Provider.of<MyProvider>(context,
                                                      listen: false)
                                                  .confettiContanier = false;
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
                                          action: "save data",
                                          checkConfetti:
                                              Provider.of<MyProvider>(context,
                                                      listen: false)
                                                  .confettiContanier,
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 30),
                                        child: PlayerInfoWIdget(
                                          name: Provider.of<MyProvider>(context,
                                                          listen: false)
                                                      .invisibleName ==
                                                  true
                                              ? Provider.of<MyProvider>(context,
                                                      listen: false)
                                                  .playerO
                                              : Provider.of<MyProvider>(context,
                                                      listen: false)
                                                  .defaultName1,
                                          defaultName: Provider.of<MyProvider>(
                                                  context,
                                                  listen: false)
                                              .player2,
                                          playerPoint1: Provider.of<MyProvider>(
                                                  context,
                                                  listen: false)
                                              .playerPoint2
                                              .toString(),
                                          onTap: () {
                                            setState(() {
                                              initalizeGame();
                                              Provider.of<MyProvider>(context,
                                                      listen: false)
                                                  .confettiContanier = false;
                                              Provider.of<MyProvider>(context,
                                                      listen: false)
                                                  .colorX = Colors.green;
                                              Provider.of<MyProvider>(context,
                                                      listen: false)
                                                  .colorO = Colors.red;
                                              Provider.of<MyProvider>(context,
                                                      listen: false)
                                                  .gameEnd = false;
                                            });
                                          },
                                          action: 'play this players',
                                          checkConfetti:
                                              Provider.of<MyProvider>(context,
                                                      listen: false)
                                                  .confettiContanier,
                                        )),
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
                                  style: GoogleFonts.aladin(
                                      textStyle: const TextStyle(
                                          color: Colors.blue,
                                          fontSize: 37,
                                          fontWeight: FontWeight.w500)),
                                )),
                        ),
                      ),
                      headerText(0),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [restartgame(), playersname()],
                        ),
                      ),
                      gameContainer()
                    ],
                  ),
                ),
              ));
        });
  }

  createInfo() {
    DocumentReference documentReference = pointCollection.doc();

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
      "dateTime": Provider.of<MyProvider>(context, listen: false).data,
      //"dateHours":Provider.of<MyProvider>(context, listen: false).hours.hour.toString(),
      "userId": currentUser.uid
    };
    documentReference.set(info).whenComplete(
          () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const PointScreen())),
        );
  }
}
