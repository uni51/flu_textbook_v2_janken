import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

import 'package:janken/main.dart';

class NextPage extends StatefulWidget {
  final String preResultText;

  const NextPage({super.key, required this.preResultText});

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  Timer? timer;
  Hand? myHand;
  Hand? computerHand;
  Result? result;

  late String preResult;

  @override
  void initState() {
    super.initState();

    // 受け取ったデータを状態を管理する変数に格納
    preResult = widget.preResultText;
  }

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

    Result result;

    result = Result.draw;
    if (preResult == '勝ち') {
      if (myHand == computerHand) {
        result = Result.win;
      }
    }
    if (preResult == '負け') {
      if (myHand == computerHand) {
        result = Result.lose;
      }
    }

    if (result == Result.draw) {
      timer = Timer(
        const Duration(seconds: 1), //遅延時間＝2秒
        () {
          // コールバックを渡しておく。ここに遷移メソッドは書いておく
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MyHomePage(title: 'じゃんけんゲーム'),
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
        title: const Text('あっち向いてほいゲーム'),
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
              style: const TextStyle(fontSize: 100),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              result?.text ?? '?',
              style: const TextStyle(fontSize: 40),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              result?.resultText() ?? '?',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              myHand?.text ?? '?',
              style: const TextStyle(fontSize: 200),
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

  String resultText() {
    switch (this) {
      case Result.win:
        return 'おめでとうございます\nゲームクリアです。';
      case Result.lose:
        return '残念。あなたの負けが確定しました。';
      case Result.draw:
        return 'もう一度じゃんけんしてください。';
    }
  }
}
