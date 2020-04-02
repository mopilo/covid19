import 'dart:convert';

import 'package:covid_19/src/core/services/home_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main(){
test("Testing the network call", () async{
  //setup the test
  final home = HomeApiProvider();
  home.client = MockClient((request) async {
    final mapJson = {'content':[]};
    return Response(json.encode(mapJson),200);
  });
  final item = await home.getPatients();
  expect(item.result, []);
});
}