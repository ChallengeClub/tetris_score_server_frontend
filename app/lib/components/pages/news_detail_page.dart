import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';


import '../../model/news_model.dart';
import '../../view_model/providers.dart';

class NewsDetailPage extends HookConsumerWidget {
  final String _id;
  NewsDetailPage(this._id);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    NewsModel? _news = ref.watch(newsDetailStateNotifierProvider(_id));
    Size _size = MediaQuery.of(context).size;

    return SelectionArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Tetris HP')),
        body: Center(
          child: (() {
            if (_news == null) {
            // 初期化後、通信中
              return CircularProgressIndicator.adaptive();
            } 
            return Container(
              width: _size.width > 700 ? 700 : _size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_news.title),
                  ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        child: const Text('close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              )
            );
          }
        )(),
        )
      )
    );
  }
}

