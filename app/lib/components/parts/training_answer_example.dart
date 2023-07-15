import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/services.dart';

class TrainingAnswerExample extends HookConsumerWidget {
  final String _answer;
  final String _status;
  TrainingAnswerExample(this._status, this._answer);  
  final TextEditingController _codeEditingController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOpened = useState(false);
    Size _size = MediaQuery.of(context).size;
    _codeEditingController.text = _answer;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
            Container(
                child: ((){
                    if (_status == "initialized"){
                        return ElevatedButton(
                            onPressed: null,
                            child: const Text("Answer Example"),
                        );
                    } else if (_status == "finished"){
                        return Row(
                            children: [
                                ElevatedButton(
                                    onPressed: () {
                                        isOpened.value = !isOpened.value;
                                    },
                                    child: const Text("Answer Example"),
                                ),
                                SizedBox(width: 5),
                                OutlinedButton(
                                    child: const Text('copy', style: TextStyle(fontSize: 10)),
                                    style: OutlinedButton.styleFrom(
                                        primary: Colors.black,
                                        foregroundColor: Colors.grey,
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5),
                                        ),
                                        side: const BorderSide(color: Colors.grey, width: 0.5),
                                    ),
                                    onPressed: () async {
                                        await Clipboard.setData(
                                            ClipboardData(text: _answer),
                                        );
                                    },
                                )
                            ]
                        );
                    }
                })()
            ),            
            Container(
                child: ((){
                    if (isOpened.value==true){
                        return Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: TextField(
                                enabled:false,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                expands: true,
                                controller: _codeEditingController,
                                style: TextStyle(fontSize: 10)
                            ),
                            height: _size.height*0.4,
                            decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(3),
                            ),
                        );
                    } else {
                        return SizedBox(height: 0);
                    }
                })()
            ),
        ]
    );
  }
}