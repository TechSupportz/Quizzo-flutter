import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quizzo/question.dart';
import 'quiz_logic.dart';

QuizLogic quizLogic = QuizLogic();

void main() {
  runApp(const Quizzo());
}

class Quizzo extends StatelessWidget {
  const Quizzo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: QuizScreen(),
          ),
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Widget> scoreKeeperList = [
    // Icon(
    //   Icons.check,
    //   color: Colors.green,
    //   size: 24,
    // ),
    // Icon(
    //   Icons.close,
    //   color: Colors.red,
    // ),
  ];

  void checkAnswer(bool userAnswer) {
    if (quizLogic.getAnswer() == userAnswer) {
      setState(() {
        scoreKeeperList.add(
          const Icon(
            Icons.check,
            color: Colors.green,
            size: 24,
          ),
        );
        debugPrint('user is correct!');
        checkProgress();
      });
    } else {
      setState(() {
        scoreKeeperList.add(
          const Icon(
            Icons.close,
            color: Colors.red,
            size: 24,
          ),
        );
        debugPrint('user is wrong :(');
        checkProgress();
      });
    }
  }

  void checkProgress() {
    if (scoreKeeperList.length >= quizLogic.getQnListLength()) {
      scoreKeeperList = [];
      quizLogic.restartQuiz();
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Quiz Completed'),
          content: const Text('You have made it to the and of the quiz'),
          actions: [
            TextButton(
              onPressed: () => setState(
                () {
                  Navigator.pop(context);
                },
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    } else {
      quizLogic.nextQuestion();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Center(
            child: Text(
              quizLogic.getQuestion(),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 25.0),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
                onPressed: () {
                  debugPrint('true was pressed');
                  checkAnswer(true);
                },
                child: const Text(
                  'True',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                )),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
                debugPrint('false was pressed');
                checkAnswer(false);
              },
              child: const Text(
                'False',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            children: [
              if (scoreKeeperList.isEmpty)
                const SizedBox(
                  width: 24,
                  height: 24,
                )
              else
                ...scoreKeeperList,
            ],
          ),
        )
      ],
    );
  }
}
