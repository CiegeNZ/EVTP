import 'dart:convert';
import 'dart:io';
import 'package:evtp/Tools/Location/location.dart';
import "package:http/http.dart" as http;

final String API_KEY = "b24b03b6-73b9-48b6-8d4f-d5bd5a31169e";

Future<dynamic> getChargeStations(bounds) async {
  try {
    bounds = bounds.toString().split('(');
    print(bounds);
    //var location = await getLocationString();
    String baseURL = "https://api.openchargemap.io/v3/poi/?output=json";
    String request = baseURL +
        "&client=evtp-app&distanceunit=km&verbose=false" +
        "&boundingbox=(" +
        bounds[2].toString().split(' ')[0] +
        bounds[2].toString().split(' ')[1].split(')')[0] +
        "),(" +
        bounds[3].toString().split(' ')[0] +
        bounds[3].toString().split(' ')[1].split(')')[0] +
        ")&key=" +
        API_KEY; //add polyline
    print("request: " + request);
    Map<String, String> userHeaders = {HttpHeaders.userAgentHeader: "evtp-app"};
    var response = await http.get(Uri.parse(request), headers: userHeaders);
    print("Response: " + response.body);
    var jsonreturn = json.decode(response.body);
    return jsonreturn;
  } catch (e) {
    throw (e);
  }
}
