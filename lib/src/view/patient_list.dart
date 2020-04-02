import 'package:covid_19/src/core/bloc/home_bloc.dart';
import 'package:covid_19/src/core/model/patient_model.dart';
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
      body: Container(
        child: StreamBuilder(
          stream: homebloc.patientData,
          builder: (context, AsyncSnapshot<PatientModel> snapshot) {
            if(snapshot.hasData){
              var patient = snapshot.data.result;
              return ListView.builder(
                itemCount: patient.length,
                shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) { 
                return Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.4),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text( 'Name: ' + patient[index].firstname + " " + patient[index].lastname),
                      Text('Gender: ' + patient[index].gender),
                      Text('City: ' + patient[index].city),
                      Text('State: ' + patient[index].state),
                      Text('Lat: ' + patient[index].lat),
                      Text('Lng: ' + patient[index].lng),
                    ],
                  ),
                );
               },);
            }
            else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
            
          }
        ),
      ),
    );
  }
}