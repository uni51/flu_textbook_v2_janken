import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  String myJankenText = '👊️';
  String computerJankenText = '?';

  List<String> jankenList = ['👊', '✌️', '✋️'];

  void chooseComputerText() {
    final random = Random();
    final randomNumber = random.nextInt(3);
    final computerJankenText = jankenList[randomNumber];
    setState(() {
      this.computerJankenText = computerJankenText;
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
            Text(
              '相手',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              computerJankenText,
              style: TextStyle(fontSize: 100),
            ),
            const SizedBox(height: 80,),
            Text(
              myJankenText,
              style: TextStyle(fontSize: 200),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                myJankenText = '👊️';
              });
              chooseComputerText();
            },
            tooltip: 'Increment',
            child: const Text('👊️', style: TextStyle(fontSize: 30),),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                myJankenText = '✌️';
              });
              chooseComputerText();
            },
            tooltip: 'Increment',
            child: const Text('✌️', style: TextStyle(fontSize: 30),),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                myJankenText = '✋';
              });
              chooseComputerText();
            },
            tooltip: 'Increment',
            child: const Text('✋', style: TextStyle(fontSize: 30),),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
