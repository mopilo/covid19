import 'package:covid_19/src/components/input.dart';
import 'package:covid_19/src/components/snack.dart';
import 'package:covid_19/src/core/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class DataCapture extends StatefulWidget{
  final states, location;
  DataCapture({this.states, this.location});
  @override
  _DataCaptureState createState() => _DataCaptureState();
}

class _DataCaptureState extends State<DataCapture> {
  final formKey = new GlobalKey<FormState>(); 
  String _gender;
  String _state;
  String _street, _city, _fname, _lname;
  bool _inProgress = false;

  var gender = <String>['MALE', 'FEMALE'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ModalProgressHUD(
        inAsyncCall: _inProgress,
        child: Container(
          margin: EdgeInsets.only(left: 30),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Input(
                    label: 'First Name',
                    onSaved: (value) => _fname = value,
                    validator: (value) => value.isEmpty ? 'First Name can\'t be empty' : null,
                  ),
                  Input(
                    label: 'Last Name',
                    onSaved: (value) => _lname = value,
                    validator: (value) => value.isEmpty ? 'last Name can\'t be empty' : null,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1, color: Colors.grey))
                    ),
                    child: DropdownButtonHideUnderline(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: DropdownButton(
                          isExpanded: true,
                          hint: Text(
                            'Gender',
                            textAlign: TextAlign.left,
                          ),
                          value: _gender,
                          items: gender.map((value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              _gender = value;
                              // data = snapshot.data.result;
                            });
                          },
                        ),
                      )
                    ),
                  ),
                  Input(
                    label: 'Street',
                    onSaved: (value) => _street = value,
                    validator: (value) => value.isEmpty ? 'Street can\'t be empty' : null,
                  ),
                  Input(
                    label: 'City',
                    onSaved: (value) => _city = value,
                    validator: (value) => value.isEmpty ? 'City can\'t be empty' : null,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1, color: Colors.grey))
                    ),
                    child: DropdownButtonHideUnderline(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: DropdownButton(
                          isExpanded: true,
                          hint: Text(
                            'State',
                            textAlign: TextAlign.left,
                          ),
                          value: _state,
                          items: widget.states.map<DropdownMenuItem<String>>((value) =>
                         new DropdownMenuItem<String>(
                          value: value.name,
                          child: new Text(value.name),
                        )
                      ).toList(),
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              _state = value;
                              // data = snapshot.data.result;
                            });
                          },
                        ),
                      )
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () async{
                        final form = formKey.currentState;
                        form.save();
                        FocusScope.of(context).requestFocus(new FocusNode());
                        if (form.validate() && _gender != null && _state != null) {
                        if(widget.location != null){
                          
                        
                        setState(() {_inProgress = true;});
                        await homebloc.upload(_fname, _lname, _city, _street, _gender, _state, widget.location.latitude, widget.location.longitude, context).then((success) {
                          setState(() {
                            _inProgress = false;
                          });
                          print(success);
                          if (success != null) {
                            Navigator.pop(context);
                          }
                        });}
                        else{
                          showMessage('Please turn on your location service', context);
                        }
                        }
                      },
                      color: Colors.blue,
                      child: Text('Submit', style: TextStyle(color: Colors.white))
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}