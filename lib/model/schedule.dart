class Schedule {
  String _professionalID;
  int _startTime;
  int _endTime;
  int _breakStartTime;
  int _breakEndTime;
  int _duration;
  String _dayOfWeek;

  Schedule.professionalSchedule(Map snapshot)
      : _startTime = snapshot['start_time'],
        _endTime = snapshot['end_time'],
        _breakStartTime = snapshot['break_start_time'],
        _breakEndTime = snapshot['break_end_time'],
        _duration = snapshot['duration'];

  String getProfessionalID() {
    return _professionalID;
  }

  void setProfessionalID(String professionalID) {
    _professionalID = professionalID;
  }

  int getStartTime() {
    return _startTime;
  }

  void setStartTime(int startTime) {
    _startTime = startTime;
  }

  int getEndTime() {
    return _endTime;
  }

  void setEndTime(int endTime) {
    _endTime = endTime;
  }

  int getBreakStartTime() {
    return _breakStartTime;
  }

  void setBreakStartTime(int breakStartTime) {
    _breakStartTime = breakStartTime;
  }

  int getBreakEndTime() {
    return _breakEndTime;
  }

  void setBreakEndTime(int breakEndTime) {
    _breakEndTime = breakEndTime;
  }

  int getDuration() {
    return _duration;
  }

  void setDuration(int duration) {
    _duration = duration;
  }

  String getDayOfWeek() {
    return _dayOfWeek;
  }

  void setDayOfWeek(String dayOfWeek) {
    _dayOfWeek = dayOfWeek;
  }
}
