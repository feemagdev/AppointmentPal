class Company {
  String _companyID;
  String _name;
  String _address;
  String _contact;
  String _image;

  Company.defaultConstructor();

  Company.fromMap(Map snapshot, String companyID)
      : _name = snapshot['name'],
        _address = snapshot['address'],
        _contact = snapshot['contact'],
        _image = snapshot['image'],
        _companyID = companyID;

  String getCompanyAddress() {
    return _address;
  }

  void setCompanyAddress(String address) {
    _address = address;
  }

  String getName() {
    return _name;
  }

  void setName(String name) {
    _name = name;
  }

  String getContact() {
    return _contact;
  }

  void setContact(String contact) {
    _contact = contact;
  }

  String getImage() {
    return _image;
  }

  void setImage(String image) {
    _image = image;
  }

  String getCompanyID() {
    return _companyID;
  }
}
