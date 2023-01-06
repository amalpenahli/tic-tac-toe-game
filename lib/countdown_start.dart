import 'package:flutter/material.dart';

import 'package:neon_circular_timer/neon_circular_timer.dart';
import 'package:tic_tac_game/functions/button_sound.dart';
import 'package:tic_tac_game/provider/provider_info.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

import 'functions/snacbar_bottom.dart';

class CountdownStart extends StatefulWidget {
  const CountdownStart({super.key});

  @override
  State<CountdownStart> createState() => _CountdownStartState();
}

class _CountdownStartState extends State<CountdownStart> {
  late CountDownController controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: NeonCircularTimer(
                onComplete: () {
                  controller.pause();

                  (Provider.of<MyProvider>(context, listen: false).duration > 9
                      ? showMessagee(context)
                      : Provider.of<MyProvider>(context, listen: false)
                          .duration);
                  if (Provider.of<MyProvider>(context, listen: false)
                          .duration >=
                      10) {
                    buttonTimesUp();
                    Provider.of<MyProvider>(context, listen: false).gameEnd =
                        true;
                    Provider.of<MyProvider>(context, listen: false)
                        .currentPlayer = "end game";
                    return;
                  }
                },
                width: 130,
                controller: controller,
                duration:
                    Provider.of<MyProvider>(context, listen: false).duration,
                strokeWidth: 5,
                isTimerTextShown: true,
                neumorphicEffect: true,
                outerStrokeColor: Colors.grey.shade100,
                innerFillGradient: LinearGradient(
                    colors: [Colors.orange, Colors.blueAccent.shade400]),
                neonGradient: LinearGradient(
                    colors: [Colors.orange, Colors.blueAccent.shade400]),
                strokeCap: StrokeCap.round,
                innerFillColor: Colors.black12,
                backgroudColor: Colors.grey.shade100,
                neonColor: Colors.blue.shade900),
          ),
          Row(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () {
                      buttonPlay();
                      controller.resume();
                    }),

                IconButton(
                    icon: const Icon(Icons.pause),
                    onPressed: () {
                      //bax bura////////////////////////////////////////////////////
                      setState(() {
                        if (Provider.of<MyProvider>(context, listen: false)
                                .timer ==
                            false) {
                          controller.pause();
                        } else if (Provider.of<MyProvider>(context,
                                    listen: false)
                                .timer ==
                            true) {
                          controller.pause();
                        }
                      });

                      buttonStop();
                    }),
                //         IconButton(
                //             icon: Icon(Icons.repeat),
                //             onPressed: () {
                //             cont.restart();
                //             }),
              ])
        ],
      ),
    );
  }
}
