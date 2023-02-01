import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './pizza_question.dart';
import './pizza_answer.dart';

void main() => runApp(MyApp());

// ignore: use_key_in_widget_constructors
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  // ignore: non_constant_identifier_names
  void _IWasTapped() {
    setState(() {
      _questionIndex += 1;
    });
    if (kDebugMode) {
      print("I was tapped");
    }
  }

  var questions = [
    {
      'question': "Select type of clothes",
      'answer': [
        'Jackets',
        'Jeans',
        'T-Shirts',
      ],
    },
    {
      'question': "Select category",
      'answer': [
        'Man',
        'Women',
      ],
    },
    {
      'question': "Select size",
      'answer': [
        'S',
        'M',
        'L',
        'XL',
        'XXL',
      ],
    },
  ];
  var _questionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hello World",
      home: Scaffold(
        // ignore: prefer_const_constructors
        appBar: AppBar(title: Text("Clothes shopping")),
        body: Column(
          children: [
            PizzaQuestion(questions[_questionIndex]['question'] as String),
            ...(questions[_questionIndex]['answer'] as List<String>)
                .map((answer) {
              return PizzaAnswer(_IWasTapped, answer);
            }),
          ],
        ),
      ),
    );
  }
}
