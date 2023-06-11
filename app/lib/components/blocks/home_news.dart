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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
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
                ),
                Container(
                    height: 110,
                    child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                            return Container(
                                height: 26,
                                child: Text(_news[index].title, style: TextStyle(fontSize: 10,)),
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
            ]
        )
    );
  }
}