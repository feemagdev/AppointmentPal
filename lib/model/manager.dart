class Manager {
  String _managerID;
  String _name;
  String _phone;
  String _country;
  String _city;
  String _address;
  String _companyID;
  String _image;

  Manager.fromMap(Map snapshot, String managerID)
      : _managerID = managerID,
        _name = snapshot['name'],
        _phone = snapshot['phone'],
        _country = snapshot['country'],
        _city = snapshot['city'],
        _address = snapshot['address'],
        _image = snapshot['image'],
        _companyID = snapshot['companyID'];

  Manager.defaultConstructor();

  String getManagerID() {
    return _managerID;
  }

  void setManagerID(String managerID) {
    _managerID = managerID;
  }

  String getCity() {
    return _city;
  }

  void setCity(String city) {
    _city = city;
  }

  String getCountry() {
    return _country;
  }

  void setCountry(String country) {
    _country = country;
  }

  String getAddress() {
    return _address;
  }

  void setAddress(String address) {
    _address = address;
  }

  String getPhone() {
    return _phone;
  }

  void setPhone(String phone) {
    _address = phone;
  }

  String getName() {
    return _name;
  }

  void setName(String name) {
    _name = name;
  }

  String getCompanyID() {
    return _companyID;
  }

  void setCompanyID(String companyID) {
    _companyID = companyID;
  }

  void setImage(String image) {
    _image = image;
  }

  String getImage() {
    return _image;
  }
}
