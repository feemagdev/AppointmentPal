class WeekDaysAvailability {
  bool _monday;
  bool _tuesday;
  bool _wednesday;
  bool _thursday;
  bool _friday;
  bool _saturday;
  bool _sunday;

  WeekDaysAvailability.defaultConstructor();

  Map<String, dynamic> toMap(bool monday, bool tuesday, bool wednesday,
      bool thursday, bool friday, bool saturday, bool sunday) {
    return {
      'monday': monday,
      'tuesday': tuesday,
      'wednesday': wednesday,
      'thursday': thursday,
      'friday': friday,
      'saturday': saturday,
      'sunday': sunday
    };
  }

  WeekDaysAvailability.fromMap(Map snapshot)
      : _monday = snapshot['monday'],
        _tuesday = snapshot['tuesday'],
        _wednesday = snapshot['wednesday'],
        _thursday = snapshot['thursday'],
        _friday = snapshot['friday'],
        _saturday = snapshot['saturday'],
        _sunday = snapshot['sunday'];

  bool getMondayAvailability() {
    return _monday;
  }

  bool getTuesdayAvailability() {
    return _tuesday;
  }

  bool getWednesdayAvailability() {
    return _wednesday;
  }

  bool getThursdayAvailability() {
    return _thursday;
  }

  bool getFridayAvailability() {
    return _friday;
  }

  bool getSaturdayAvailability() {
    return _saturday;
  }

  bool getSundayAvailability() {
    return _sunday;
  }

  void setMondayAvailability(bool status) {
    _monday = status;
  }

  void setTuesdayAvailability(bool status) {
    _tuesday = status;
  }

  void setWednesdayAvailability(bool status) {
    _wednesday = status;
  }

  void setThursdayAvailability(bool status) {
    _thursday = status;
  }

  void setFridayAvailability(bool status) {
    _friday = status;
  }

  void setSaturdayAvailability(bool status) {
    _saturday = status;
  }

  void setSundayAvailability(bool status) {
    _sunday = status;
  }
}
