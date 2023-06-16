import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../model/news_model.dart';
import '../../view_model/providers.dart';

class HomeNewsField extends ConsumerWidget{
  double _width;
  double _height;
  HomeNewsField(this._width, this._height);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<NewsModel> _news = ref.watch(newsStateNotifierProvider);
    return Container(
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
                height: 140,
                child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: _width*0.08),
                        height: 40,
                        child: Container(
                            child: Column(
                                children: [
                                Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(_news[index].created_at_string, style: TextStyle(fontSize: 10,)),
                                ),
                                SizedBox(height: 3),
                                Container(
                                    padding: const EdgeInsets.only(left: 20),
                                    alignment: Alignment.bottomLeft,
                                    child: Text(_news[index].title, style: TextStyle(fontSize: 12,), overflow: TextOverflow.ellipsis)
                                )
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
                    itemCount: _news.length > 3? 3 : _news.length,
                    separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                            height: 5,
                        );
                    }
                )
            ),
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => context.go('/news'),
                child: const Text('News list→'),
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ),
            ),          
          ]
      )
    );
  }
}