import 'package:flutter/material.dart';
import 'package:quiz_app/topic_selection_page.dart';
import 'package:quiz_app/quiz_page.dart';
import 'package:quiz_app/questions.dart';
import 'package:quiz_app/results_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TopicSelectionPage(),
    );
  }
}

class TopicSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a topic'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Topic 1'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuizPage(topic: 'Topic 1')),
                );
              },
            ),
            RaisedButton(
              child: Text('Topic 2'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuizPage(topic: 'Topic 2')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  final String topic;

  QuizPage({Key key, this.topic}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _questionIndex = 0;
  int _score = 0;

  List<Question> _questions = [
    Question(
      'Question 1',
      ['Answer 1', 'Answer 2', 'Answer 3', 'Answer 4'],
      0,
    ),
    Question(
      'Question 2',
      ['Answer 1', 'Answer 2', 'Answer 3', 'Answer 4'],
      1,
    ),
    Question(
      'Question 3',
      ['Answer 1', 'Answer 2', 'Answer 3', 'Answer 4'],
      2,
    ),
    Question(
      'Question 4',
      ['Answer 1', 'Answer 2', 'Answer 3', 'Answer 4'],
      3,
    ),
  ];

  void _answerQuestion(int answerIndex) {
    if (_questions[_questionIndex].correctAnswerIndex == answerIndex) {
      setState(() {
        _score++;
      });
    }

    if (_questionIndex < _questions.length - 1) {
      setState(() {
        _questionIndex++;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsPage(
            score: _score,
            totalQuestions: _questions.length,
            topic: widget.topic,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.topic),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              _questions[_questionIndex].question,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            ..._questions[_questionIndex].answers.map((answer) {
              int answerIndex =
                  _questions[_questionIndex].answers.indexOf(answer);
              return RaisedButton(
                child: Text(answer),
                onPressed: () => _answerQuestion(answerIndex),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class Question {
  String question;
  List<String> answers;
  int correctAnswerIndex;

  Question(this.question, this.answers, this.correctAnswerIndex);
}

class ResultsPage extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final String topic;

  ResultsPage({Key key, this.score, this.totalQuestions, this.topic})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Congratulations!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'You scored $score out of $totalQuestions!',
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            SizedBox(height: 16.0),
            RaisedButton(
              child: Text('Take another quiz'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TopicSelectionPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
