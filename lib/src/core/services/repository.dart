import 'package:covid_19/src/core/services/home_provider.dart';

class Repository {
  final stateApiProvider = HomeApiProvider();
  Future getStates() => stateApiProvider.getStates();

   final patientApiProvider = HomeApiProvider();
  Future getPatients() => patientApiProvider.getPatients();

  final uploadApiProvider = HomeApiProvider();
  Future upload(fname, lname, city, street, gender, state) => uploadApiProvider.upload(fname, lname, city, street, gender, state);
}
