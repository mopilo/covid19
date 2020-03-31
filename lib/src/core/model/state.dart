class StateModel {
  List<_Result> results;
  StateModel.fromJson(List<dynamic> json) {
    print('=======================================');
    // print(json);
   this.results = [];
   final _resultList = json;
    for (var i = 0; i < json.length; i++) {
      this.results.add(new _Result.fromJson(_resultList[i]));
    }
  }
    List<_Result> get result => results;

}
class _Result {
  String name;
  int id;
  _Result.fromJson(Map<String, dynamic> jsonMap) {
    this.name = jsonMap['name'];
    this.id = jsonMap['id'];

  }
  
}