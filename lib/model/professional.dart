
import 'package:appointmentproject/model/sub_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Professional {
  String _professionalID;
  String _name;
  String _phone;
  String _country;
  String _city;
  String _address;
  Timestamp _dob;
  String _image;
  int _appointmentCharges;
  int _experience;
  SubServices _subServices;
  GeoPoint _appointmentLocation;

  Professional.defaultConstructor();

  Professional.fromMap(Map snapshot, SubServices subServices)
      :
        _name = snapshot['name'],
        _phone = snapshot['phone'],
        _country = snapshot['country'],
        _city = snapshot['city'],
        _address = snapshot['address'],
        _dob = snapshot['dob'],
        _image = snapshot['image'],
        _appointmentCharges = snapshot['appointmentCharges'],
        _experience = snapshot['experience'],
        _subServices = subServices,
        _appointmentLocation = snapshot['appointmentLocation'];

  Future<List<Professional>> getListOfProfessionalsBySubService(
      String subServiceID) async {
    List<Professional> listOfProfessionals = [];
    final dbReference = Firestore.instance;
    DocumentReference subServiceReference =
        getSubServiceReference(subServiceID);
    SubServices subServices = await SubServices.defaultConstructor()
        .getSubService(subServiceReference);
     dbReference
        .collection('professional')
        .where('sub_serviceID', isEqualTo: subServiceReference)
        .getDocuments()
        .then((value) {
      value.documents.forEach((element)  {
        Professional professional;
        professional = Professional.fromMap(element.data, subServices);
        professional.setProfessionalID(element.documentID);
        listOfProfessionals.add(professional);
      });
    });
    return listOfProfessionals;
  }


  Future<SubServices> getSubService(DocumentReference documentReference) async {
    return await SubServices.defaultConstructor()
        .getSubService(documentReference);
  }

  DocumentReference getSubServiceReference(String subServiceID) {
    return SubServices.defaultConstructor()
        .getSubServiceReference(subServiceID);
  }


  Timestamp getDob() {
    return _dob;
  }

  void setDob(Timestamp dob) {
    _dob = dob;
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

  String getImage(){
    return _image;
  }

  void setImage(String image){
    _image = image;
  }

  int getAppointmentCharges(){
    return _appointmentCharges;
  }

  void setAppointmentCharges(int appointmentCharges){
    _appointmentCharges = appointmentCharges;
  }
  int getExperience(){
    return _experience;
  }

  void setExperience(int experience){
    _experience = experience;
  }

  SubServices getSubServices(){
    return _subServices;
  }

  void setSubServices(SubServices subServices){
    _subServices = subServices;
  }

  GeoPoint getAppointmentLocation(){
    return _appointmentLocation;
  }

  void setAppointmentLocation(GeoPoint appointmentLocation) {
    _appointmentLocation = appointmentLocation;
  }

  String getProfessionalID (){
    return _professionalID;
  }

  void setProfessionalID (String professionalID){
    _professionalID = professionalID;
  }


}
