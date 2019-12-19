class Calendar {
  int _day;
  int _month;
  int _year;
  int _weekDay;

  Calendar(this._day, this._month, this._year, this._weekDay);

  //setters
  
  set day(int day){
    this._day = day;
  }

    set month(int month){
    this._month = month;
  }


  set year(int year){
    this._year = year;
  }


  set weekDay(int weekDay){
    this._weekDay = weekDay;
  }

  //getters

  int get day => this._day;
  int get month => this._month;
  int get year => this._year;
  int get weekDay => this._weekDay;

}