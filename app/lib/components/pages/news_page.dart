import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../model/news_model.dart';
import '../../view_model/providers.dart';
import '../blocks/custom_appbar.dart';
import '../blocks/user_menu_drawer.dart';

class NewsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<NewsModel> _news = ref.watch(newsStateNotifierProvider);
    Size _size = MediaQuery.of(context).size;
    double _width = _size.width;
    double _height = _size.height;
    double _news_line_height = _height*0.07;
    double _news_line_width = _width;
    return Scaffold(
      appBar: CustomAppbar(title: const Text('Tetris News Page')),
      endDrawer: UserMenuDrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: _height*0.02, horizontal: _width*0.05),
          width: _news_line_width,
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
                height: _news.length*_news_line_height+10,
                child: ListView.builder(
                  itemCount: _news.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () => context.push('/news/${_news[index].id}'),
                      child: Container(
                      padding: EdgeInsets.symmetric(horizontal: _news_line_width*0.08),
                      height: _news_line_height,
                      child: Container(
                          child: Column(
                            children: [
                              Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(_news[index].created_at_string, style: TextStyle(fontSize: 10,)),
                              ),
                              SizedBox(height: 3),
                              Container(
                                  padding: EdgeInsets.only(left: _news_line_width*0.05),
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
                      )
                    );
                  },
                )
              ),
            ]
          )
        )
      )
    );
  }
}
