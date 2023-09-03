import 'dart:math';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatRoomField extends StatefulWidget {
  const ChatRoomField({Key? key}) : super(key: key);

  @override
  ChatRoom createState() => ChatRoom();
}

class ChatRoom extends State<ChatRoomField> {
  final List<types.Message> _messages = [];
  late types.User _user;
  final types.User _tetris = const types.User(
    id: 'tetris',
    firstName: "Smino",
    lastName: "",
    imageUrl: "images/Smino.jpg",
  );
  ApiService? _apiService;

  @override
  void initState() {
    super.initState();
    _addMessage(types.TextMessage(
      author: _tetris,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: "ご用件はなんですか？",
    ));

    _apiService = ApiService();
    initializeAsyncMethods();
  }
  Future<void> initializeAsyncMethods() async {
    String? identityId = _apiService?.getIdentityId;
    _user = types.User(id: identityId ?? 'xxxxx-xxxxx-xxxxx');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('tetrisチャット')),
      body: Chat(
        user: _user,
        messages: _messages,
        onSendPressed: _handleSendPressed,
        showUserAvatars: true,
        showUserNames: true,
      ),
    );
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);
    //Map<String, dynamic>? apiResponseData = await _apiService?.performAuthorizedPost(message.text);
    Map<String, dynamic>? apiResponseData = await _apiService?.performAuthorizedGet();
    final responseText = apiResponseData?['message'] ?? 'Failed';
    debugPrint(responseText);

    final responseMessage = types.TextMessage(
      author: _tetris,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: responseText,
    );
    _addMessage(responseMessage);
  }
}

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class ApiService {
  String? _identityId;
  String? get getIdentityId => _identityId;
  static const apiUrl = 'https://ms2pp1ypcf.execute-api.ap-northeast-1.amazonaws.com/Stage/chat';

  Future<Map<String, dynamic>> performAuthorizedGet() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return jsonResponse;
    }else{
      return {'status': 'Error'};
    }
  }

  Future<Map<String, dynamic>> performAuthorizedPost(String inputText) async {
    debugPrint("post message");
    Map<String, dynamic> data = {
      'input_text': inputText,
      'identity_id': 'identity_id',
      'character_name': 'character_name',
    };
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      try {
        var jsonResponse = json.decode(response.body);
        return jsonResponse;
      } catch (e) {
        debugPrint("Error decoding response: $e");
        return {'status': 'Error', 'message': 'Invalid response format'};
      }
    } else {
      return {'status': 'Error'};
    }
  }

  Future<void> signOut() async {
    try {
      debugPrint('Successfully signed out');
    } catch (e) {
      debugPrint('Error signing out: $e');
    }
  }
}
