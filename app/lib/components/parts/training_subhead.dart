import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TrainingSubhead extends ConsumerWidget {
  final String _text;
  TrainingSubhead(this._text);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Text(_text, style: TextStyle(fontSize: 15)),
    );
  }
}