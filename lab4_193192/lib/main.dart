import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:lab3/notifications_service.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:lab3/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService.initNotifications();
  runApp(ExamsApp(
      flutterLocalNotificationsPlugin:
          NotificationService.flutterLocalNotificationsPlugin));
}

class ExamsApp extends StatelessWidget {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  const ExamsApp({super.key, required this.flutterLocalNotificationsPlugin});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exams and midterms',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: LoginScreen(
        onLogin: (String username, String password) {},
      ),
    );
  }
}

class Exam {
  final String text;
  final DateTime date;

  Exam({required this.text, required this.date});
}

class ExamsList extends StatefulWidget {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  ExamsList(
      {Key? key,
      required this.title,
      required this.flutterLocalNotificationsPlugin})
      : super(key: key);

  final String title;

  @override
  _ExamsListState createState() => _ExamsListState();
}

class _ExamsListState extends State<ExamsList> {
  List<Exam> examsList = [
    Exam(text: 'Math', date: DateTime(2023, 3, 30)),
    Exam(text: 'English', date: DateTime(2023, 3, 3, 17, 51)),
    Exam(text: 'Physics', date: DateTime(2023, 3, 28))
  ];

  late final Map<DateTime, String> _events = {
    examsList[0].date: examsList[0].text,
    examsList[1].date: examsList[1].text
  };

  @override
  void initState() {
    for (int i = 0; i < examsList.length; i++) {
      _events[examsList[i].date] = examsList[i].text;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showDialog() {
    String? textValue;
    DateTime? dateValue;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Insert exam name and date'),
          content: Column(
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  textValue = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Exam name',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: Text(dateValue == null
                    ? 'Select the exam date'
                    : DateFormat('dd/MM/yyyy').format(dateValue!)),
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2024),
                  ).then((date) {
                    setState(() {
                      dateValue = date;
                    });
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
                if (textValue != null && dateValue != null) {
                  setState(() {
                    examsList.add(Exam(text: textValue!, date: dateValue!));
                    _events.putIfAbsent(dateValue!, () => textValue!);
                  });
                  NotificationService.scheduleNotification(
                      Exam(text: textValue!, date: dateValue!));
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(tabs: [
            Tab(
              text: 'Exams list',
            ),
            Tab(
              text: 'Calendar',
            ),
          ]),
          title: const Text('Exams and midterms list'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _showDialog,
            )
          ],
        ),
        body: TabBarView(
          children: [
            Scaffold(
              body: ListView.builder(
                itemCount: examsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: Colors.white70,
                    elevation: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              examsList[index].text.toUpperCase(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                            Text(
                              DateFormat('dd/MM/yyyy')
                                  .format(examsList[index].date),
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TableCalendar(
                  calendarBuilders:
                      CalendarBuilders(markerBuilder: (context, date, events) {
                    List<Widget> markers = [];

                    var dateFirstPart = date.toString().split(" ")[0];
                    var keyValuePairs =
                        _events.entries.map((e) => "${e.key} ${e.value}");

                    Map<String, String> map = {};
                    for (String keyValue in keyValuePairs) {
                      map[keyValue.split(" ")[0]] = keyValue.split(" ")[2];
                    }

                    if (map.keys.contains(dateFirstPart.toString())) {
                      markers.add(
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Text(
                            map.remove(dateFirstPart.toString())!,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                      );
                    }
                    return Stack(
                      children: markers,
                    );
                  }),
                  rowHeight: 100,
                  focusedDay: DateTime.now(),
                  firstDay: DateTime.now(),
                  lastDay: DateTime(2024),
                  headerStyle: const HeaderStyle(
                      formatButtonVisible: false, titleCentered: true),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
