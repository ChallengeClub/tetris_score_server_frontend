import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';


import '../../model/result_model.dart' as ResultModel;
import '../blocks/result_detail_table.dart' as ResultDetailTable;
import '../../view_model/providers.dart';

class ResultDetailPage extends HookConsumerWidget {
  final String _id;
  ResultDetailPage(this._id);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ResultModel.ResultModel? result = ref.watch(resultDetailStateNotifierProvider);
    ref.read(resultDetailStateNotifierProvider.notifier).fetchResultDetailById(_id);
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(title: const Text('Tetris HP')),
        body: Center(
          child: (() {
            if (result == null) {
            // 初期化後、通信中
              return CircularProgressIndicator.adaptive();
            } 
            return Container(
              width: _size.width > 700 ? 700 : _size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Image.network('https://github.com/${result.github_user_name}.png'),
                    title: Text(result.name),
                    subtitle: Text(
                      result.repository_url,
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                    trailing: OutlinedButton(
                      onPressed: null, // disable button 
                      child: Text(result.status),
                      style: ButtonStyle(
                        textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
                          (_) {
                            return TextStyle(
                              color: Colors.black
                            );
                          },
                        ),
                        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                          (_) {
                            Color color = Colors.white;
                            if (result.status=="succeeded"){
                              color = Color(0xFFE2F6DF);
                            } else if (result.status=="error"){
                              color = Color(0xFFFADBDF);
                            } else if (result.status=="evaluating"){
                              color = Color(0xE6FFF7DF);
                            }
                            return color;
                          },
                        ),
                      )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Datetime",
                                      style: TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "created:\n ${result.created_at_string}\nstarted:\n ${result.started_at_string}\nended:\n ${result.ended_at_string}",
                                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                    ),
                                  ]
                                )
                              ),
                              SizedBox(width: 20),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Configurations",
                                      style: TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "level: ${result.level}\nmode: ${result.game_mode}\nweight: ${result.predict_weight_path}\ngame_time: ${result.game_time}\ntrials: ${result.trial_number}",
                                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                    ),
                                  ]
                                )
                              ),
                              SizedBox(width: 20),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Score Stats",
                                      style: TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "mean: ${result.mean_score_string}\nstddev: ${result.stddev_score_string}\nmax: ${result.max_score}\nmin: ${result.min_score}",
                                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                    ),
                                  ]
                                )
                              ),
                            ]
                          )
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: _size.height*0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Details",
                                style: TextStyle(fontWeight: FontWeight.w600)
                              ),
                              SizedBox(height: 5),
                              ((){
                                if (result.status=="error"){
                                  return Text(result.error_message ?? "");
                                } else {
                                  return Expanded(
                                    child: ResultDetailTable.ResultDetailTable(result)
                                  );
                                }
                              })(),
                            ]
                          )
                        ),
                      ]
                    )
                  ),
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
    );
  }
}

