import 'dart:convert';

import 'package:covid_19/src/core/services/app_exception.dart';

class Callbacks {
  dynamic returnResponse(response) {
    print(response.statusCode);
    print(response.body);
    print("object");

    switch (response.statusCode) {
      case 200:
      case 204:
      case 201:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(json.decode(response.body)['message']);
      case 422:
        throw UnProcessed(json.decode(response.body)['message']);
      case 401:
      case 403:
        throw UnauthorisedException(json.decode(response.body)['message']);
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  
}
  