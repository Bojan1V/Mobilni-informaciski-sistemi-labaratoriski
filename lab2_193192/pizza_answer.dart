import 'package:flutter/material.dart';

class PizzaAnswer extends StatelessWidget {
  String answerText;
  VoidCallback tapped;
  PizzaAnswer(this.tapped, this.answerText);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        answerText,
        style: TextStyle(color: Colors.red, backgroundColor: Colors.green),
      ),
      onPressed: tapped,
    );
  }
}
