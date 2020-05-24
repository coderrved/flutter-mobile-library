class Time{

  int _timeId;
  int _time;

  int get timeId => _timeId;

  set id(int value) {
    _timeId = value;
  }
  int get time => _time;

  set time(int value) {
    _time = value;
  }

  Time(this._time);

  Map<String, dynamic>toMap(){

    var map = Map<String, dynamic>();

    map['id']=_timeId;
    map['time']=_time;

    return map;

  }

  Time.fromMap(Map<String, dynamic> map){

    this._timeId = map['timeId'];
    this._time = map['time'];

  }

  @override
  String toString() {
    return 'Users{_id: $_timeId, _time: $_time}';
  }


}