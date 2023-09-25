import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

import 'package:janken/main.dart';

class NextPage extends StatefulWidget {
  const NextPage({super.key});

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  Timer? timer;
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

    if (myHand != computerHand) {
      result = Result.draw;
    } else {
      result = Result.win;
    }

    if (result == Result.draw) {
      timer = Timer(
        const Duration(seconds: 1), //遅延時間＝2秒
            () {
          // コールバックを渡しておく。ここに遷移メソッドは書いておく
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
              const MyHomePage(title: 'Flutter Demo Home Page'),
            ),
          );
        },
      );
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
                myHand = Hand.left;
              });
              chooseComputerText();
            },
            tooltip: 'left',
            child: const Text(
              '👈',
              style: TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: 'up',
            onPressed: () {
              setState(() {
                myHand = Hand.up;
              });
              chooseComputerText();
            },
            tooltip: 'up',
            child: const Text(
              '👆️',
              style: TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: 'right',
            onPressed: () {
              setState(() {
                myHand = Hand.right;
              });
              chooseComputerText();
            },
            tooltip: 'right',
            child: const Text(
              '👉',
              style: TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: 'down',
            onPressed: () {
              setState(() {
                myHand = Hand.down;
              });
              chooseComputerText();
            },
            tooltip: 'down',
            child: const Text(
              '👇',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

enum Hand {
  left,
  up,
  right,
  down;

  String get text {
    switch (this) {
      case Hand.left:
        return '👈';
      case Hand.up:
        return '👆';
      case Hand.right:
        return '👉';
      case Hand.down:
        return '👇';
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
