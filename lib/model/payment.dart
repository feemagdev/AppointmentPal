class Payment {
  String _paymentID;
  DateTime _paymentDateTime;
  DateTime _subscriptionEndDate;
  int _amount;
  String _professionalID;
  String _managerID;

  Payment.defaultConstructor();

  Payment.professionalMap(Map snapshot, String paymentID)
      : _paymentDateTime = snapshot['payment_date_time'].toDate(),
        _subscriptionEndDate = snapshot['subscription_end_date'].toDate(),
        _professionalID = snapshot['professionalID'],
        _paymentID = paymentID;

  Payment.managerMap(Map snapshot, String paymentID)
      : _paymentDateTime = snapshot['payment_date_time'],
        _subscriptionEndDate = snapshot['subscription_end_date'],
        _managerID = snapshot['managerID'],
        _paymentID = paymentID;

  Map<String, dynamic> professionalMap({
    DateTime paymentDateTime,
    DateTime subscriptionEndDate,
    String professionalID,
    int amount,
  }) {
    return {
      'payment_date_time': paymentDateTime,
      'subscription_end_date': subscriptionEndDate,
      'professionalID': professionalID
    };
  }

  Map<String, dynamic> managerMap(
      {DateTime paymentDateTime,
      DateTime subscriptionEndDate,
      String managerID,
      int amount}) {
    return {
      'payment_date_time': paymentDateTime,
      'subscription_end_date': subscriptionEndDate,
      'managerID': managerID
    };
  }

  void setPaymentDateTime(DateTime paymentDateTime) {
    _paymentDateTime = paymentDateTime;
  }

  DateTime getPaymentDateTime() {
    return _paymentDateTime;
  }

  DateTime getSubscriptionEndDate() {
    return _subscriptionEndDate;
  }

  void setSubscriptionEndDate(DateTime subscriptionEndDate) {
    _subscriptionEndDate = subscriptionEndDate;
  }

  String getPaymentID() {
    return _paymentID;
  }

  String getProfessionalID() {
    return _professionalID;
  }

  String getManagerID() {
    return _managerID;
  }

  int getAmount() {
    return _amount;
  }

  void setAmount(int amount) {
    _amount = amount;
  }
}
