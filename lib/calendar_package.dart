library calendar_package;

import 'package:flutter/material.dart';
import 'calendarPage.dart';
import 'calendarBloc.dart';
import 'calendar.dart';

class DateSelectionWidget extends StatefulWidget {
  @override
  _DateSelectionWidgetState createState() => _DateSelectionWidgetState();
}

class _DateSelectionWidgetState extends State<DateSelectionWidget> {
  final CalendarBloc _calendarBloc = CalendarBloc();

  @override
  void dispose() {
    super.dispose();
    _calendarBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Calendar>>(
      initialData: _calendarBloc.calendarList,
      stream: _calendarBloc.calendarListStream,
      builder: (BuildContext context, AsyncSnapshot<List<Calendar>> snapshot) {
        return Container(
          height: MediaQuery.of(context).size.height / 8,
          width: MediaQuery.of(context).size.width,
          child: InkWell(
            onTap: () {
              _calendarBloc.flag = true;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CalendarPage()));
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 4.0, color: Theme.of(context).accentColor)),
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          _calendarBloc.months[snapshot.data[0].month] +
                              ' ' +
                              '${snapshot.data[0].day}',
                          style: TextStyle(fontSize: 35.0)),
                      Text('${snapshot.data[0].year}',
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold))
                    ],
                  ),
                  Text(
                    'to',
                    style: TextStyle(fontSize: 40.0),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          _calendarBloc.months[snapshot.data[1].month] +
                              ' ' +
                              '${snapshot.data[1].day}',
                          style: TextStyle(fontSize: 35.0)),
                      Text('${snapshot.data[1].year}',
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold))
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
