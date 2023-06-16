import 'package:state_notifier/state_notifier.dart';

import '../repository/db_repository.dart';
import '../model/news_model.dart';


class NewsDetailStateNotifier extends StateNotifier<NewsModel?> {
  final DBRepository _dbRepository;
  final String _id;
  
  NewsDetailStateNotifier(this._dbRepository, this._id) : super(null){
    fetchNewsDetailById(_id);
  }
  Future<void> fetchNewsDetailById(String _id) async {
    try{
      state = await _dbRepository.getNewsDetailById(_id);
      // await Future.delayed(Duration(seconds: 0));
      // state = NewsModel(
      //   "1",
      //   "Hello News Detail",
      //   1000000000,
      //   "aaaaaaaaaa",
      //   "テトリスHPのホーム画面を大幅アップデートしました\nNewsフィールドではテトリスHPや大会の開催情報に関するニュースを発信します\nContentsフィールドはスコアサーバページや大会エントリーページ、開発中のtrainingページへ遷移するリンクを掲載しています。\n今後もアップデートを重ねていきますので、ご期待ください！",
      // );
    } catch(e){
      print(e);
    }
  }
}