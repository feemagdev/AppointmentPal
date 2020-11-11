class CustomTimeSlots {
  String _timeSlotID;
  DateTime _from;
  DateTime _to;

  CustomTimeSlots.defaultConstructor();

  Map<String, dynamic> toMap(DateTime from, DateTime to) {
    return {'from': from, 'to': to};
  }

  CustomTimeSlots.fromMap(Map snapshot, String timeSlotID)
      : _timeSlotID = timeSlotID,
        _from = snapshot['from'],
        _to = snapshot['to'];

  String getTimeSlotID() {
    return _timeSlotID;
  }

  DateTime getFromTime() {
    return _from;
  }

  DateTime getToTime() {
    return _to;
  }
}
