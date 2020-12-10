class Sms {
  String _smsID;
  String _professionalID;
  String _customerID;
  String _message;

  Sms.defaultConstructor();

  Sms.fromMap(Map<String, dynamic> snapshot, String smsID) {
    _smsID = smsID;
    _professionalID = snapshot['professionalID'];
    _customerID = snapshot['customerID'];
    _message = snapshot['message'];
  }

  Map<String, dynamic> smsMap(
      {String professionalID, String customerID, String message}) {
    return {
      'professionalID': professionalID,
      'customerID': customerID,
      'message': message
    };
  }

  String getSmsID() {
    return _smsID;
  }

  String getProfessionalID() {
    return _professionalID;
  }

  void setProfessionalID(String professionalID) {
    _professionalID = professionalID;
  }

  String getCustomerID() {
    return _customerID;
  }

  void setCustomerID(String customerID) {
    _customerID = customerID;
  }

  String getMessage() {
    return _message;
  }

  void setMessage(String message) {
    _message = message;
  }
}
