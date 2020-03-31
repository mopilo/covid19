import 'dart:convert';

import 'package:covid_19/src/core/model/patient_model.dart';
import 'package:covid_19/src/core/model/state.dart';
import 'package:covid_19/src/core/services/app_exception.dart';
import 'package:covid_19/src/core/services/responseData.dart';
import 'package:covid_19/src/shared/env.dart';
import 'package:http/http.dart' as http;
import 'dart:io';


class HomeApiProvider{
  List responseJson;
  Map responseData;
  var client = new http.Client();
  String url = Env().apiUrl;
  final callbacks = Callbacks(); 

  Future<StateModel> getStates() async {
    await Env().getAuthHeader().then((Map header) async {
      try {
        final response = await client.get(url + '/states', headers: header);
          responseJson = await callbacks.returnResponse(response);
      } on SocketException {
          throw FetchDataException('No Internet connection');
      }
    });
    return StateModel.fromJson(responseJson);
  }


  Future<PatientModel> getPatients() async {
    await Env().getAuthHeader().then((Map header) async {
      try {
        final response = await client.get(url + '/patients', headers: header);
          responseData = await callbacks.returnResponse(response);
      } on SocketException {
          throw FetchDataException('No Internet connection');
      }
    });
    return PatientModel.fromJson(responseData);
  }

  Future upload(fname, lname, city, street, gender, state) async {
    Map body = {
      "city": city,
      "firstname": fname,
      "gender": gender,
      "lastname": lname,
      "state": state,
      "street": street,
      "lat": '',
      "lng": ''
    };
    print(body);

    // await Env().getAuthHeader().then((Map header) async {
    //   try {
    //     final response = await client.post('$url/patients', headers: header, body: json.encode(body));
    //       responseJson = await callbacks.returnResponse(response);
    //   } on SocketException {
    //       throw FetchDataException('No Internet connection');
    //   }
    // });
    // return responseJson;
  }


  // Future postReview(r, t, id, route) async {
  //   Map body = {
  //     "rating" : {
  //       "star": r,
  //       "comment": t,
  //     }
  //   };
  //       // print(body);

  //   await Env().getHeader().then((Map header) async {
  //     try {
  //       final response = await client.post(
  //        route == 'spa'? url + '/listings/'+id.toString() + "/reviews" : 
  //        url + '/specialists/' + id.toString()+ '/reviews', 
  //         headers: header, body: json.encode(body)
  //       );
  //         responseJson = await callbacks.returnResponse(response);
  //     } on SocketException {
  //         throw FetchDataException('No Internet connection');
  //     }
  //   });
  //   return responseJson;
  // }
}