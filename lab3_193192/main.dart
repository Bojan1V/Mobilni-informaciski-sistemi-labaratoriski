import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './pizza_question.dart';
import './pizza_answer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Organizer',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Student Organizer', elements: [
        "Diskretna matematika",
        "Mobilni informaciski sistemi",
        "Veb programiranje",
        "Biznis statistika",
        "Strukturno programiranje",
        "OOP",
        "Marketing",
        "Kompjuterski merzi",
        "Bazi na podatoci",
        "Integirani sistemi",
        "internet tehnologii",
        "Mobilni aplikacii",
        "Algoritmi i podatocni strukturi",
      ], dateAndTime: [
        "10.02.2023 10:00",
        "11.02.2023 11:00",
        "12.02.2023 12:00",
        "13.02.2023 13:00",
        "14.02.2023 14:00",
        "15.02.2023 15:00",
        "16.02.2023 16:00",
        "17.02.2023 11:00",
        "18.02.2023 18:00",
        "19.02.2023 09:00",
        "20.02.2023 08:00",
        "21.02.2023 12:30",
        "22.02.2023 10:30",
      ]),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  final List<String> elements;
  final List<String> dateAndTime;

  const MyHomePage(
      {required this.title, required this.elements, required this.dateAndTime});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: elements.length,
        itemBuilder: (contx, index) {
          print(elements[index]);
          return Card(
            elevation: 6, //senka na kartickata
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  child: Text(
                    dateAndTime[index],
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(contx).primaryColorDark, width: 3),
                  ),
                  child: Text(
                    elements[index],
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      print("The subject is added");
                    },
                    icon: Icon(Icons.add))
              ],
            ),
          );
        },
      ),
    );
  }
}
