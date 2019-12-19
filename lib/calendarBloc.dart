import 'dart:async';
import 'calendar.dart';

class CalendarBloc {

  List<String> months = ['', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  List<String> monthHeadings = ['', 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'Sepember', 'October', 'November', 'December'];

  bool flag;

  static final CalendarBloc _calendarBloc = CalendarBloc._internal();

  factory CalendarBloc(){
    return _calendarBloc;
  }
  
  List<Calendar> _calendarList = [
    Calendar(DateTime.now().day, DateTime.now().month, DateTime.now().year, DateTime.now().weekday),
    Calendar(DateTime.now().day, DateTime.now().month, DateTime.now().year, DateTime.now().weekday)
  ];

  List<Calendar> get calendarList => _calendarList;

  final _calendarListStreamController = StreamController<List<Calendar>>.broadcast();

  //for selection
  final _calendarStartDateStreamController = StreamController<Calendar>();
  final _calendarEndDateStreamController = StreamController<Calendar>();

  //getters
  Stream<List<Calendar>> get calendarListStream => _calendarListStreamController.stream;
  StreamSink<List<Calendar>> get calendarListSink => _calendarListStreamController.sink;
  
  StreamSink<Calendar> get calendarStartDate => _calendarStartDateStreamController.sink;
  StreamSink<Calendar> get calendarEndDate => _calendarEndDateStreamController.sink;


  CalendarBloc._internal(){
    _calendarListStreamController.add(_calendarList);

    _calendarStartDateStreamController.stream.listen(_selectStartDate);
    _calendarEndDateStreamController.stream.listen(_selectEndDate);
  }

  _selectStartDate(Calendar calendar){
    _calendarList[0].day = calendar.day;
    _calendarList[0].month = calendar.month;
    _calendarList[0].year = calendar.year;
    _calendarList[0].weekDay = calendar.weekDay;

    calendarListSink.add(_calendarList);
  }

  _selectEndDate(Calendar calendar){
    _calendarList[1].day = calendar.day;
    _calendarList[1].month = calendar.month;
    _calendarList[1].year = calendar.year;
    _calendarList[1].weekDay = calendar.weekDay;

    calendarListSink.add(_calendarList);
  }

  void dispose(){
    _calendarListStreamController.close();
    _calendarStartDateStreamController.close();
    _calendarEndDateStreamController.close();
  }
}