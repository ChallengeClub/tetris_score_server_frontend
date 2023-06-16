import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/news_model.dart';
import '../../view_model/providers.dart';

class NewsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<NewsModel> _news = ref.watch(newsStateNotifierProvider);
    Size _size = MediaQuery.of(context).size;
    double _width = _size.width;
    double _height = _size.height;
    return Scaffold(
      appBar: AppBar(title: const Text('Tetris News Page')),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: _height*0.02, horizontal: _width*0.05),
        width: _width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                child: Text(
                    "News", 
                    style: TextStyle(
                        fontSize: 20,
                    ),
                ),
                padding: EdgeInsets.only(bottom: _width*0.05)
            ),
            Container(
              height: _news.length*30+10,
              child: ListView.builder(
                itemCount: _news.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: _width*0.08),
                    height: 30,
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            width: _width*0.25,
                            alignment: Alignment.topLeft,
                            child: Text(_news[index].created_at_string, style: TextStyle(fontSize: 10,)),
                          ),
                          SizedBox(width: 5),
                          Text(_news[index].title, style: TextStyle(fontSize: 15,))
                        ]
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey, //枠線の色
                            width: 0.5, //枠線の太さ
                          ),
                        ),
                      ),
                    )
                  );
                },
              )
            ),
          ]
        )
      )
    );
  }
}
