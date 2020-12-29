import 'package:http/http.dart' as http;

class ListDataSrvice {
  _setHeaders() => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  String baseUrl = "https://jsonplaceholder.typicode.com/";

  doData() async {
    var fullurl = baseUrl + "posts";
    return await http.get(fullurl);
  }
}
