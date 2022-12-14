import 'package:app/constance/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  //Font Custom Function
  bool oTurn = true;
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];
  List<int> matchIndex = [];
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  String resultDeclaration = '';
  bool winnerFound = false;
  Timer? timer;
  static const maxSec = 30;
  int seconds = maxSec;
  int attemps = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainTheme.pColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Player O',
                          style: TextStyle(fontSize: 28, color: Colors.white),
                        ),
                        Text(
                          oScore.toString(),
                          style: TextStyle(fontSize: 28, color: Colors.white),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Player X',
                          style: TextStyle(fontSize: 28, color: Colors.white),
                        ),
                        Text(
                          xScore.toString(),
                          style: TextStyle(fontSize: 28, color: Colors.white),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _tapped(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            width: 5,
                            color: MainTheme.pColor,
                          ),
                          color: matchIndex.contains(index)
                              ? MainTheme.accColor
                              : MainTheme.sColor,
                        ),
                        child: Center(
                          child: Text(
                            displayXO[index],
                            style: TextStyle(
                                fontSize: 56, color: MainTheme.pColor),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      resultDeclaration,
                      style: TextStyle(fontSize: 30),
                    ),
                    buildTimer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _tapped(int index) {
    final isRun = timer == null ? false : timer!.isActive;
    if (isRun) {
      setState(() {
        if (oTurn && displayXO[index] == '') {
          displayXO[index] = 'O';
          print(index);
          filledBoxes++;
        } else if (!oTurn && displayXO[index] == '') {
          displayXO[index] = 'X';
          print(index);
          filledBoxes++;
        }

        oTurn = !oTurn;
        checkWinner();
      });
    }
  }

  void checkWinner() {
    //1st row
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[0] + ' Wins!';
        matchIndex.addAll([0, 1, 2]);
        stopTimer();
        updateScore(displayXO[0]);
      });
    }

    //2st row
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[3] + ' Wins!';
        matchIndex.addAll([3, 4, 5]);
        stopTimer();
        updateScore(displayXO[3]);
      });
    }
    //3rd row
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[6] + ' Wins!';
        matchIndex.addAll([6, 7, 8]);
        stopTimer();
        updateScore(displayXO[6]);
      });
    }
    //1st column
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[0] + ' Wins!';
        matchIndex.addAll([0, 3, 6]);
        stopTimer();
        updateScore(displayXO[0]);
      });
    }
    //2nd column
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[1] + ' Wins!';
        matchIndex.addAll([1, 4, 7]);
        stopTimer();
        updateScore(displayXO[1]);
      });
    }
    //3rd column
    if (displayXO[3] == displayXO[5] &&
        displayXO[3] == displayXO[8] &&
        displayXO[3] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[3] + ' Wins!';
        matchIndex.addAll([3, 5, 8]);
        stopTimer();
        updateScore(displayXO[3]);
      });
    }
    //diagonal
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[0] + ' Wins!';
        matchIndex.addAll([0, 4, 8]);
        stopTimer();
        updateScore(displayXO[0]);
      });
    }
    //8st row
    if (displayXO[2] == displayXO[4] &&
        displayXO[2] == displayXO[6] &&
        displayXO[2] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[2] + ' Wins!';
        matchIndex.addAll([2, 4, 6]);
        stopTimer();
        updateScore(displayXO[2]);
      });
    }
    if (!winnerFound && filledBoxes == 9) {
      setState(() {
        resultDeclaration = 'Draw!!';
      });
    }
  }

  void updateScore(String winner) {
    if (winner == 'O') {
      oScore += 1;
    } else if (winner == 'X') {
      xScore += 1;
    }
    winnerFound = true;
  }

  void clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] = '';
      }
      resultDeclaration = '';
    });
    filledBoxes = 0;
  }

  Widget buildTimer() {
    final isRun = timer == null ? false : timer!.isActive;
    return isRun
        ? SizedBox(
            width: 80,
            height: 80,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 - seconds / maxSec,
                  valueColor: AlwaysStoppedAnimation(Colors.pink),
                  strokeWidth: 8,
                  backgroundColor: MainTheme.accColor,
                ),
                Center(
                  child: Text(
                    '$seconds',
                    style: TextStyle(
                        fontSize: 36,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          )
        : ElevatedButton(
            onPressed: () {
              startTimer();
              clearBoard();
              attemps++;
            },
            child: Text(
              attemps == 0 ? 'Start' : 'Play Again!',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 36, vertical: 16)),
          );
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    resetTimer();
    timer?.cancel();
  }

  void resetTimer() {
    seconds = maxSec;
  }
}
