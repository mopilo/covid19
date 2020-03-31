import 'dart:async';
import 'package:covid_19/src/components/snack.dart';
import 'package:covid_19/src/core/model/patient_model.dart';
import 'package:covid_19/src/core/model/state.dart';
import 'package:covid_19/src/core/services/repository.dart';
import 'package:rxdart/rxdart.dart';


class HomeBloc {
  final _repository = Repository();

  final _state = PublishSubject<StateModel>();
  final _patient = PublishSubject<PatientModel>();


  Stream<StateModel> get stateData => _state.stream;
  Stream<PatientModel> get patientData => _patient.stream;

  final _loader = BehaviorSubject<bool>();
  Stream<bool> get progress => _loader.stream;


  Future getStates() async {
    _loader.sink.add(true);
    StateModel stateModel;
    try{
      stateModel = await _repository.getStates();
      _state.sink.add(stateModel);
      _loader.sink.add(false);
    }
    catch(e){
      print(e);
      _loader.sink.add(false);
      _state.addError(e);
    }
    return stateModel;
  }


  Future getPatients() async {
    _loader.sink.add(true);
    PatientModel patientModel;
    try{
      patientModel = await _repository.getPatients();
      _patient.sink.add(patientModel);
      _loader.sink.add(false);
    }
    catch(e){
      print(e);
      _loader.sink.add(false);
      _patient.addError(e);
    }
    return patientModel;
  }
  

    upload(fname, lname, city, street, gender, state, cxt) async {
    _loader.sink.add(true);
    var success;
    try{
      success = await _repository.upload(fname, lname, city, street, gender, state);
      _loader.sink.add(false);
    }catch(e){
      _loader.sink.add(false);
       showMessage(e.toString(), cxt);
    }
    return success; 
  }

  dispose() {
    _loader.close();
    _state.close();
    _patient.close();
  }
}

final homebloc = HomeBloc();
