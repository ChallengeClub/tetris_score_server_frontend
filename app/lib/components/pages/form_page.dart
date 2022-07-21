import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../blocks/form.dart';

class FormPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tetris評価サーバ 入力フォーム"),
      ),
      body: Center(
        child: Container(margin: const EdgeInsets.all(40), child: SubmitForm()),
      ),
    );
  }
}
