import 'package:state_notifier/state_notifier.dart';

import '../repository/db_repository.dart';
import '../model/news_model.dart';


class NewsStateNotifier extends StateNotifier<List<NewsModel>> {
  final DBRepository _dbRepository;  
  NewsStateNotifier(this._dbRepository) : super([]){
    fetchNews();
  }

  Future<void> fetchNews() async {
    try{
      state = []; // initialize state and display the circle indicator
      List<NewsModel> news = await _dbRepository.getNews();
      news.sort((b,a)=>a.created_at.compareTo(b.created_at));
      state = news;
    } catch(e){
      print(e);
    }
  }
}