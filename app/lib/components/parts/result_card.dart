import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/result_model.dart';

class ResultsCard extends StatelessWidget {
  final ResultModel result;
  const ResultsCard({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(result.repository_url),
            subtitle: Text("${result.created_at}"),
          )
        ],
      ),
      margin: const EdgeInsets.all(5),
      elevation: 8, // 影の離れ具合
      shadowColor: Colors.black ,// 影の色
      shape: RoundedRectangleBorder( // 枠線を変更できる
        borderRadius: BorderRadius.circular(10),
      ),
    );;
  }
}
