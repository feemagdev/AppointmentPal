class Customer {
  String _customerID;
  String _name;
  String _phone;
  String _address;
  String _city;
  String _country;

  Map<String, dynamic> toMap(String name, String phone, String address,
      String city, String country) {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'city': city,
      'country': country,
    };
  }

  Customer.defaultConstructor();

  Customer.fromMap(Map snapshot, String customerID)
      : _name = snapshot['name'],
        _phone = snapshot['phone'],
        _address = snapshot['address'],
        _city = snapshot['city'],
        _country = snapshot['country'],
        _customerID = customerID;

  String getCustomerID() {
    return _customerID;
  }

  String getName() {
    return _name;
  }

  String getPhone() {
    return _phone;
  }

  String getAddress() {
    return _address;
  }

  String getCity() {
    return _city;
  }

  String getCountry() {
    return _country;
  }

  void setName(String name) {
    _name = name;
  }

  void setPhone(String phone) {
    _phone = phone;
  }

  void setAddress(String address) {
    _address = address;
  }

  void setCity(String city) {
    _city = city;
  }

  void setCountry(String country) {
    _country = country;
  }

  void setCustomerID(String customerID) {
    _customerID = customerID;
  }
}
