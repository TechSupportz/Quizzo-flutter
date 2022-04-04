import 'package:flutter/material.dart';

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

  List<String> questionList = [
    'You can lead a cow down stairs but not up stairs.',
    'Approximately one quarter of human bones are in the feet.',
    'A slug\'s blood is green.',
  ];

  int currentQnNum = 0;

  void updateQnNum() {
    if (currentQnNum + 1 >= questionList.length) {
      setState(() {
        currentQnNum = 0;
      });
    } else {
      setState(() {
        currentQnNum++;
      });
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
              questionList[currentQnNum],
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
                  updateQnNum();
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
                updateQnNum();
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
