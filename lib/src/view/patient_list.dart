import 'package:covid_19/src/core/bloc/home_bloc.dart';
import 'package:flutter/material.dart';

class PatientList extends StatefulWidget{
  @override
  _PatientListState createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {

  @override
    void initState() {
      super.initState();
      homebloc.getPatients();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}