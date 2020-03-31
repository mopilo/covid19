
import 'dart:async';


  class Env {
    Env();
    String apiUrl = "http://95.179.142.220";

    Future<Map> getAuthHeader() async {
      Map<String, String> header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
      return header;
    }
  
}
