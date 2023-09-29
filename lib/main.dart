import 'package:flutter/material.dart';
import 'dart:math';
import 'next_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'じゃんけんゲーム',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'じゃんけんゲーム'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        title: Text(widget.title),
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
            if (result == Result.win || result == Result.lose) ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NextPage(preResultText: result!.text)),
                  );
                },
                child: const Text('あっち向いてほいゲームへ')),
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
            heroTag: 'rock',
            onPressed: () {
              setState(() {
                myHand = Hand.rock;
              });
              chooseComputerText();
            },
            tooltip: 'rock',
            child: const Text(
              '👊️',
              style: TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: 'scissors',
            onPressed: () {
              setState(() {
                myHand = Hand.scissors;
              });
              chooseComputerText();
            },
            tooltip: 'scissors',
            child: const Text(
              '✌️',
              style: TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: 'paper',
            onPressed: () {
              setState(() {
                myHand = Hand.paper;
              });
              chooseComputerText();
            },
            tooltip: 'paper',
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

  String koreanText() {
    switch (this) {
      case Result.win:
        return '승리';
      case Result.lose:
        return '패배';
      case Result.draw:
        return '무승부';
    }
  }
}
