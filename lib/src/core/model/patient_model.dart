class PatientModel {
  List<_Result> results;
  PatientModel.fromJson(Map<String, dynamic> json) {
   this.results = [];
   final _resultList = json['content'];
    for (var i = 0; i < json['content'].length; i++) {
      this.results.add(new _Result.fromJson(_resultList[i]));
    }
  }
    List<_Result> get result => results;

}
class _Result {
  String firstname;
  int id;
  String lastname;
  String city;
  String street;
  String state;
  String gender;
  String lat;
  String lng;


  _Result.fromJson(Map<String, dynamic> jsonMap) {
    this.firstname = jsonMap['firstname'];
    this.id = jsonMap['id'];
    this.lastname = jsonMap['lastname'];
    this.city = jsonMap['city'];
    this.street = jsonMap['street'];
    this.state = jsonMap['state'];
    this.gender = jsonMap['gender'];
    this.lat = jsonMap['lat'];
    this.lng = jsonMap['lng'];
  }
}