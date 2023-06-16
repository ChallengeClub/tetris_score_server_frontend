import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../model/news_model.dart';


class HomeNewsField extends HookConsumerWidget{
  List<NewsModel> _news = [
        NewsModel("a", "hello news 1", 1, "https://tetris-server.challenge-club.org", "こんにちは"),
        NewsModel("b", "hello news 2", 2, "https://tetris-server.challenge-club.org", "こんにちは"),
        NewsModel("c", "hello news 3", 4, "https://tetris-server.challenge-club.org", "こんにちは"),
  ];
  double _width;
  double _height;
  HomeNewsField(this._width, this._height);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                height: _news.length*30+10,
                child: ListView.separated(
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
                onPressed: () {},
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