import 'package:calendar_package/calendarBloc.dart';
import 'package:flutter/material.dart';
import 'package:calendar_package/calendar_package.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CalendarBloc _calendarBloc = CalendarBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print(_calendarBloc.calendarList[0].day);
            print(_calendarBloc.calendarList[0].month);
            print(_calendarBloc.calendarList[0].year);
            print(_calendarBloc.calendarList[1].day);
            print(_calendarBloc.calendarList[1].month);
            print(_calendarBloc.calendarList[1].year);
          },
          backgroundColor: Colors.red,
        ),
        appBar: AppBar(),
        body: DateSelectionWidget());
  }
}
