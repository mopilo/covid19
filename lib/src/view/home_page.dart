import 'package:covid_19/src/core/bloc/home_bloc.dart';
import 'package:covid_19/src/core/model/state.dart';
import 'package:covid_19/src/view/data_capture.dart';
import 'package:covid_19/src/view/patient_list.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Position _currentPosition;

  @override
  void initState() {
    super.initState();
    homebloc.getStates();
    getCurrentLocation();
  }

  getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_currentPosition);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
        child: Text('HomePage', style: TextStyle(color:Colors.black, fontSize: 30),),
          
        ),
        elevation: 0,
      ),
     body: Container(
       alignment: Alignment.center,
       margin: EdgeInsets.symmetric(horizontal: 40),
       child: StreamBuilder(
         stream: homebloc.stateData,
         builder: (context, AsyncSnapshot<StateModel> snapshot) {
           if(snapshot.hasData){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> DataCapture(states: snapshot.data.result, location: _currentPosition)));
                    },
                    child: homeData('Upload Data', Icons.person_add)
                  ),
                SizedBox(height: 30),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> PatientList()));
                    },
                    child: homeData('Patient details', Icons.folder_shared)
                  ),
              ],
            );
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

  Widget homeData(header, icon){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: Color(0xfff5f5f5)

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        Icon(icon, color: Colors.grey, size: 30,),
        SizedBox(width: 10),
        Text(header, style: TextStyle(),)
      ]
      )
    );
  }
}