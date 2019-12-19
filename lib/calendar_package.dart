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
  void dispose(){
    super.dispose();
    _calendarBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder<List<Calendar>>(
          initialData: _calendarBloc.calendarList,
          stream: _calendarBloc.calendarListStream,
          builder: (BuildContext context, AsyncSnapshot<List<Calendar>> snapshot){
            return Center(
              child: Container(
                height: MediaQuery.of(context).size.height / 8,
                width: MediaQuery.of(context).size.width,
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    
                    InkWell(
                      splashColor: Colors.tealAccent[400],
                      onTap: (){
                        _calendarBloc.flag = true;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CalendarPage()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.lightBlue[400]
                        ),
                        width: MediaQuery.of(context).size.width / 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(_calendarBloc.months[snapshot.data[0].month] + ' ' + '${snapshot.data[0].day}', style: TextStyle(fontSize: 35.0)),
                            Text('${snapshot.data[0].year}', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    ),

                    InkWell(
                      splashColor: Colors.lightBlue[400],
                      onTap: (){
                        _calendarBloc.flag = false;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CalendarPage()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.tealAccent[400]
                        ),
                        width: MediaQuery.of(context).size.width / 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(_calendarBloc.months[snapshot.data[1].month] + ' ' + '${snapshot.data[1].day}', style: TextStyle(fontSize: 35.0)),
                            Text('${snapshot.data[1].year}', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    )

                  ],
                ),
              ),
            );
          },
        ),
    );
  }
}