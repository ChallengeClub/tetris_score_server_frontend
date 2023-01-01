import 'dart:io';
import 'dart:io' show Platform;
import 'dart:async';


void main() async {
  
  String? _port = Platform.environment["MOCK_SERVER_PORT"];
  if (_port == null){
    throw Exception("MOCK_SERVER_PORT must not be null");
  }
  var server = await HttpServer.bind(InternetAddress.anyIPv4, int.parse(_port));
  var body = await File('test/repository/results.json').readAsString();
  await server.forEach((HttpRequest request) {
    request.response.write(body);
    request.response.close();
  });
}