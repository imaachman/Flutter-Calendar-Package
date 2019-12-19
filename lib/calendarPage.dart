import 'package:flutter/material.dart';
import 'calendar.dart';
import 'calendarBloc.dart';


class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  int _day = DateTime.now().day;
  int _month = DateTime.now().month;
  int _year = DateTime.now().year;
  int _weekDay = DateTime.now().weekday;

  List _monthSet1 = [1,3,5,7,8,10,12];
  List _monthSet2 = [4,6,9,11];

  final CalendarBloc _calendarBloc = CalendarBloc();


  Widget _availableDates(int index, int month, int year){
    return StreamBuilder<List<Calendar>>(
      stream: _calendarBloc.calendarListStream,
      builder: (BuildContext context, AsyncSnapshot<List<Calendar>> snapshot) {
        return InkWell(
              borderRadius: BorderRadius.circular(30.0),
              onTap: (){
                if(_calendarBloc.flag == true){
                  if(year < _calendarBloc.calendarList[1].year){
                    _calendarBloc.calendarStartDate.add(Calendar(index, month, year, _weekDay));
                  }
                  else if(year == _calendarBloc.calendarList[1].year){
                    if(month < _calendarBloc.calendarList[1].month){
                      _calendarBloc.calendarStartDate.add(Calendar(index, month, year, _weekDay));
                    }
                    else if(month == _calendarBloc.calendarList[1].month){
                      if(index <= _calendarBloc.calendarList[1].day){
                        _calendarBloc.calendarStartDate.add(Calendar(index, month, year, _weekDay));
                      }
                      else{
                        _calendarBloc.calendarStartDate.add(Calendar(index, month, year, _weekDay));
                        _calendarBloc.calendarEndDate.add(Calendar(index, month, year, _weekDay));
                      }
                    }
                    else{
                      _calendarBloc.calendarStartDate.add(Calendar(index, month, year, _weekDay));
                      _calendarBloc.calendarEndDate.add(Calendar(index, month, year, _weekDay));
                    }
                  }
                  else{
                    _calendarBloc.calendarStartDate.add(Calendar(index, month, year, _weekDay));
                    _calendarBloc.calendarEndDate.add(Calendar(index, month, year, _weekDay));
                  }
                }
                
                else{
                  if(year > _calendarBloc.calendarList[0].year){
                    _calendarBloc.calendarEndDate.add(Calendar(index, month, year, _weekDay));
                  }
                  else if(year == _calendarBloc.calendarList[0].year){
                    if(month > _calendarBloc.calendarList[0].month){
                      _calendarBloc.calendarEndDate.add(Calendar(index, month, year, _weekDay));
                    }
                    else if(month == _calendarBloc.calendarList[0].month){
                      if(index >= _calendarBloc.calendarList[0].day){
                        _calendarBloc.calendarEndDate.add(Calendar(index, month, year, _weekDay));
                      }
                    }
                  }                  
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(width: 3.0),
                    gradient: (_calendarBloc.flag == true && index == _calendarBloc.calendarList[0].day && month == _calendarBloc.calendarList[0].month && year == _calendarBloc.calendarList[0].year)
                          || (_calendarBloc.flag == false && index == _calendarBloc.calendarList[1].day && month == _calendarBloc.calendarList[1].month && year == _calendarBloc.calendarList[1].year)
                          ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.lightBlue[400], Colors.tealAccent[400]]
                          ) : LinearGradient(colors: [Colors.white, Colors.white]),
                  ),
                      child: Center(
                    child: Text('$index')
                  ),
                ),
              ),
            );
      }
    );
      }
    

  Widget _unavailableDates(int index){
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0), 
          border: Border.all(width: 3.0),
          color: Colors.blueGrey[200]
        ),
        child: Center(
          child: Text('$index'),
        ),
      ),
    );
  }


  Widget _date(int index, int day, int month, int year){

    int _firstDay = _weekDay - (day%7 - 1);
    if(month > this._month%12){_firstDay = DateTime.parse('$year-' + month.toString().padLeft(2, '0') + '-01').weekday;}
    index -= _firstDay - 1;

    if(month != 2){
      for(int i in _monthSet1){
        if(month == i){
          if(index >= day && index <=31){
            return _availableDates(index, month, year);
          }
          else if(index > 0 && index < day){
            return _unavailableDates(index);
          }
          else{return Text('');}
        }
        }

      for(int i in _monthSet2){
        if(month == i){
          if(index >= day && index <= 30){
            return _availableDates(index, month, year);
          }
          else if(index > 0 && index < day){
            return _unavailableDates(index);
          }
          else{return Text('');}
        }
      }
    }

    if(month == 2){
      if(year%4 != 0){
        if(index >= day && index <= 28){
          return _availableDates(index, month, year);
        }
        else if(index > 0 && index < day){
          return _unavailableDates(index);
        }
        else{return Text('');}
      }
      else{
        if(index >= day && index <= 29){
          return _availableDates(index, month, year);
        }
        else if(index > 0 && index < day){
          return _unavailableDates(index);
        }
        else{return Text('');}
      }
    }
  }

  

  Widget _calendar(int day, int month, int year){

    if(month >= _month){
      year = _year;
    }
    else{
      year = _year + 1;
    }
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 8,
          child: Center(
            child: Text(_calendarBloc.monthHeadings[month], style: TextStyle(fontSize: 70.0),),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(width: MediaQuery.of(context).size.width / 7.5, height: MediaQuery.of(context).size.height / 15, child: Center(child: Text('S', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),))),
            Container(width: MediaQuery.of(context).size.width / 7.5, height: MediaQuery.of(context).size.height / 15, child: Center(child: Text('M', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),))),
            Container(width: MediaQuery.of(context).size.width / 7.5, height: MediaQuery.of(context).size.height / 15, child: Center(child: Text('T', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),))),
            Container(width: MediaQuery.of(context).size.width / 7.5, height: MediaQuery.of(context).size.height / 15, child: Center(child: Text('W', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),))),
            Container(width: MediaQuery.of(context).size.width / 7.5, height: MediaQuery.of(context).size.height / 15, child: Center(child: Text('T', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),))),
            Container(width: MediaQuery.of(context).size.width / 7.5, height: MediaQuery.of(context).size.height / 15, child: Center(child: Text('F', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),))),
            Container(width: MediaQuery.of(context).size.width / 7.5, height: MediaQuery.of(context).size.height / 15, child: Center(child: Text('S', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),))),
          ],
        ),
        Flexible(
          child: GridView.count(
            crossAxisCount: 7,
            children: List.generate(42, (index){
              return _date(index, day, month, year);
            }),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: _calendarBloc.flag == true ? Text('Check-in Date') : Text('Check-out Date'),
        backgroundColor: _calendarBloc.flag == true ? Colors.lightBlue[400] : Colors.tealAccent[400],
      ),
      body: PageView(
        children: <Widget>[
          _calendar(_day, _month, _year),
          _calendar(1, (_month + 1)%12, (_year)),
          _calendar(1, (_month + 2)%12, (_year)),
          _calendar(1, (_month + 3)%12, (_year)),
          _calendar(1, (_month + 4)%12, (_year)),
          _calendar(1, (_month + 5)%12, (_year)),
        ],
      ),
    );
  }
}