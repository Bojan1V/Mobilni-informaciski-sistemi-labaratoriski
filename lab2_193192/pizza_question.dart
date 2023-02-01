import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PizzaQuestion extends StatelessWidget {
  // ignore: prefer_final_fields
  String _questionContent;
  // ignore: use_key_in_widget_constructors
  PizzaQuestion(this._questionContent);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // ignore: prefer_const_constructors
      margin: EdgeInsets.all(5),
      child: Text(_questionContent,
          textAlign: TextAlign.center,
          // ignore: prefer_const_constructors
          style: TextStyle(
            fontSize: 20,
            color: Colors.blue,
          )),
    );
  }
}
