import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const double titleHeight = 28.0;
const double borderWidth = 0.5;
const List<Map<String, String>> listChat = [
  {'text': 'tetris競技会のルールを調べる', 'key': 'search_rule', 'require': '', 'hint': 'ミノを消した時の点数は？'},
  {'text': '強化学習の勉強がしたい（未実装）', 'key': 'learn_RL', 'require': '', 'hint': 'Q値を解説して'},
];

class ChatRoomField extends StatefulWidget {
  const ChatRoomField({super.key});

  @override
  ChatRoom createState() => ChatRoom();
}

class ChatRoom extends State<ChatRoomField> {

  String? _user;
  String? _selectedChat;
  String? _selectedHintText;
  final _apiService = ApiService();
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _apiResponseController = TextEditingController();
  final String _apiResponse = "用件をお伺いします。";

  @override
  void initState() {
    super.initState();
  }

  Future<String?> executeChatApi(String inputText) async{
    String? apiResponseString;
    final item = listChat.firstWhere((item) => item['key'] == _selectedChat, orElse: () => {});
    if (item.isNotEmpty) {
      inputText = inputText + item['require']!;
      _selectedHintText = item['hint'];
    } else {
      debugPrint('会話内容未選択');
    }
    String? identityId = "xxxx-xxxx-xxxx";
    _user = identityId ?? 'NoName';
    Map<String, dynamic>? apiResponseData = await _apiService.performAuthorizedPost(inputText);
    apiResponseString = apiResponseData['message'] ?? 'No message';
    return apiResponseString;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: borderWidth),
      ),
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 100.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'images/omocha_robot.png',
                          alignment: Alignment.topLeft,
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(width: 10),
                        DropdownButton<String>(
                          hint: const Text('問い合わせ内容\n（選択すると精度が上がります）'),
                          value: _selectedChat,
                          itemHeight: 70.0,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedChat = newValue;
                              final item = listChat.firstWhere((item) => item['key'] == newValue, orElse: () => {});
                              if (item.isNotEmpty) {
                                _selectedHintText = item['hint'];
                              } else {
                                print('該当するキーが見つかりません。');
                              }
                            });
                          },
                          items: listChat.map<DropdownMenuItem<String>>((Map<String, String> item) {
                            return DropdownMenuItem<String>(
                              value: item['key'],
                              child: Text(item['text']!),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _apiResponseController..text = _apiResponse,
                      decoration: const InputDecoration(
                        hintText: 'APIからのレスポンスがここに表示されます',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 20,
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                      readOnly: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.fromLTRB(100.0, 0.0, 8.0, 0.0),
                child: TextField(
                  controller: _inputController,
                  decoration: InputDecoration(
                    hintText: _selectedHintText ?? 'スケジュールの確認や予約を入力してください',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.only(right: 10.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      String inputText = _inputController.text;
                      _apiResponseController.text = "応答メッセージ生成中・・・";
                      var apiResponseString = await executeChatApi(inputText);
                      _apiResponseController.text = apiResponseString!;
                    },
                    child: const Text('送信', style: TextStyle(fontSize: 18.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ApiService {
  String? _identityId;
  String? get getIdentityId => _identityId;
  //static const apiUrl = 'https://fabyomkztk.execute-api.ap-northeast-1.amazonaws.com/tetris_api_stage/chat';
  static const apiUrl = 'https://ms2pp1ypcf.execute-api.ap-northeast-1.amazonaws.com/tetris_api_stage/chat';

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
}
