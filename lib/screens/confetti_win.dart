

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class winConfetti extends StatefulWidget {
  const winConfetti({super.key});

  @override
  State<winConfetti> createState() => _winConfettiState();
}

// ignore: camel_case_types
class _winConfettiState extends State<winConfetti> {
  final controller = ConfettiController();
  @override
  void initState() {
    super.initState();
    controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Scaffold(),
        ConfettiWidget(
          shouldLoop: false,
          blastDirectionality: BlastDirectionality.explosive,
          confettiController: controller,
          gravity: 0.01,
          emissionFrequency: 0.2,
          numberOfParticles: 5,
        )
      ],
    );
  }
}
