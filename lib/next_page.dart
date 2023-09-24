import 'package:flutter/material.dart';
import 'dart:math';

class NextPage extends StatefulWidget {
  const NextPage({super.key});

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  Hand? myHand;
  Hand? computerHand;
  Result? result;

  void chooseComputerText() {
    final random = Random();
    final randomNumber = random.nextInt(3);
    final hand = Hand.values[randomNumber];
    setState(() {
      computerHand = hand;
    });
    decideResult();
  }

  void decideResult() {
    if (myHand == null || computerHand == null) {
      return;
    }

    final Result result;

    if (myHand == computerHand) {
      result = Result.draw;
    } else if (myHand == Hand.rock && computerHand == Hand.scissors) {
      result = Result.win;
    } else if (myHand == Hand.scissors && computerHand == Hand.paper) {
      result = Result.win;
    } else if (myHand == Hand.paper && computerHand == Hand.rock) {
      result = Result.win;
    } else {
      result = Result.lose;
    }

    setState(() {
      this.result = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('あっち向いてほいゲーム'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '相手',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              computerHand?.text ?? '?',
              style: TextStyle(fontSize: 100),
            ),
            const SizedBox(
              height: 80,
            ),
            Text(
              result?.text ?? '?',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 80,
            ),
            Text(
              myHand?.text ?? '?',
              style: TextStyle(fontSize: 200),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'left',
            onPressed: () {
              setState(() {
                myHand = Hand.rock;
              });
              chooseComputerText();
            },
            tooltip: 'Increment',
            child: const Text(
              '👊️',
              style: TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: 'up',
            onPressed: () {
              setState(() {
                myHand = Hand.scissors;
              });
              chooseComputerText();
            },
            tooltip: 'Increment',
            child: const Text(
              '✌️',
              style: TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: 'right',
            onPressed: () {
              setState(() {
                myHand = Hand.scissors;
              });
              chooseComputerText();
            },
            tooltip: 'Increment',
            child: const Text(
              '✌️',
              style: TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: 'down',
            onPressed: () {
              setState(() {
                myHand = Hand.paper;
              });
              chooseComputerText();
            },
            tooltip: 'Increment',
            child: const Text(
              '✋',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

enum Hand {
  rock,
  scissors,
  paper;

  String get text {
    switch (this) {
      case Hand.rock:
        return '👊️';
      case Hand.scissors:
        return '✌️';
      case Hand.paper:
        return '✋';
    }
  }
}

enum Result {
  win,
  lose,
  draw;

  String get text {
    switch (this) {
      case Result.win:
        return '勝ち';
      case Result.lose:
        return '負け';
      case Result.draw:
        return 'あいこ';
    }
  }
}
