import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with TickerProviderStateMixin {
  String diceInitImage = 'assets/images/dice-1.png';
  double diceRotation = 0.0;
  bool isRolling = false;

  void rollDice() {
    if (isRolling) return;

    final random = Random();
    final randomValue = random.nextInt(6) + 1;
    final endRotation = (5 + randomValue * 360.0);

    setState(() {
      isRolling = true;
    });

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        diceInitImage = "assets/images/dice-$randomValue.png";
        diceRotation = 0.0;
        isRolling = false;
      });
    });

    // Animate the dice rolling
    final controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    final animation = Tween(begin: diceRotation, end: endRotation).animate(controller);
    animation.addListener(() {
      setState(() {
        diceRotation = animation.value;
      });
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dice'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RotationTransition(
                turns: AlwaysStoppedAnimation((diceRotation / 360)),
                child: Image.asset(
                  diceInitImage,
                  width: 200,
                  height: 200,
                ),
              ),
              ElevatedButton(
                child: Text('Roll a dice'),
                onPressed: () {
                  rollDice();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
