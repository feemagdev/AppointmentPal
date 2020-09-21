class Schedule {
  String _professionalID;
  int _startTime;
  int _startTimeMinutes;
  int _endTime;
  int _endTimeMinutes;
  int _breakStartTime;
  int _breakStartTimeMinutes;
  int _breakEndTime;
  int _breakEndTimeMinutes;
  int _duration;
  String _dayOfWeek;

  Schedule.professionalSchedule(Map snapshot)
      : _startTime = snapshot['start_time'],
        _endTime = snapshot['end_time'],
        _breakStartTime = snapshot['break_start_time'],
        _breakEndTime = snapshot['break_end_time'],
        _duration = snapshot['duration'],
        _startTimeMinutes = snapshot['start_time_minutes'],
        _endTimeMinutes = snapshot['end_time_minutes'],
        _breakStartTimeMinutes = snapshot['break_start_time_minutes'],
        _breakEndTimeMinutes = snapshot['break_end_time_minutes'];

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

  int getStartTimeMinutes() {
    return _startTimeMinutes;
  }

  void setStartTimeMinutes(int startTimeMinutes) {
    _startTimeMinutes = startTimeMinutes;
  }

  int getEndTimeMinutes() {
    return _endTimeMinutes;
  }

  void setEndTimeMinutes(int endTimeMinutes) {
    _endTimeMinutes = endTimeMinutes;
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

  int getBreakStartTimeMinutes() {
    return _breakStartTimeMinutes;
  }

  void setBreakStartTimeMinutes(int breakStartTimeMinutes) {
    _breakStartTimeMinutes = breakStartTimeMinutes;
  }

  int getBreakEndTimeMinutes() {
    return _breakEndTimeMinutes;
  }

  void setBreakEndTimeMinutes(int breakEndTimeMinutes) {
    _breakEndTimeMinutes = breakEndTimeMinutes;
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
