import 'package:mock_web_server/mock_web_server.dart';
import 'dart:io';
import 'dart:io' show Platform;
import 'dart:async';

late MockWebServer _server;

void main() {
    String? _port = Platform.environment["MOCK_SERVER_PORT"];
    if (_port == null){
      throw Exception("MOCK_SERVER_PORT must not be null");
    }
    _server = new MockWebServer(port: int.parse(_port));
    _server.start();
    var dispatcher = (HttpRequest request) async {
      if (request.uri.path == "/results") {
        return new MockResponse()
          ..httpCode = 200
          ..body = await File('test/repository/results.json').readAsString();
      } else {
        return new MockResponse()
          ..httpCode = 404
          ..body = "not found";
      }
    };
    _server.dispatcher = dispatcher;
}