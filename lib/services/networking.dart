import 'package:http/http.dart';
import 'dart:convert';

class NetworkHelper {
  final String url;
  NetworkHelper({this.url});

  Future getData() async {
    var data;
    Response response = await get(url);
    if (response.statusCode == 200) {
      data = response.body;
    } else {
      print('There is an error');
    }

    var decodedData = jsonDecode(data);
    return decodedData;
  }
}
