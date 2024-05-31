import 'dart:io';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future<String> getData() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) return response.body;

    throw const HttpException('Error occurred while fetching data');
  }
}
