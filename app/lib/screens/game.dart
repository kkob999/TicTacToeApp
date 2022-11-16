import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  //Font Custom Function

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ,
      body: Center(
        child: Text(
          'Tic Tac Toe Game',
          // style: ,
        ),
      ),
    );
  }
}
