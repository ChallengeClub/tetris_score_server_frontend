import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/services.dart';

class TrainingSampleField extends HookConsumerWidget {
  final String _text;
  final bool _is_copybutton_enabled;
  TrainingSampleField(this._text, this._is_copybutton_enabled);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(3),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Text(_text, style: TextStyle(fontSize: 10)),
                    (() {
                        if (_is_copybutton_enabled) {
                            return InkWell(
                                splashColor: Colors.black,
                                child: OutlinedButton(
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
                                            ClipboardData(text: _text),
                                        );
                                    },
                                )
                            );
                        } else {
                            return SizedBox();
                        }
                    }
                    )(),
                ]
            )
        ),
    );
  }
}