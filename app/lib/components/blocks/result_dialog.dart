import 'package:flutter/material.dart';

import '../../model/result_model.dart' as ResultModel;
import 'result_detail_table.dart' as ResultDetailTable;

Future<void> showResultDialog(BuildContext context, ResultModel.ResultModel result) async {
  var _screenSize = MediaQuery.of(context).size;

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Center(
        child: Container(
          width: _screenSize.width*0.8>600 ? 600 : _screenSize.width*0.8, // isWebScreenSize? web : mobile
          height: _screenSize.height*0.9,
          child: Card(
            clipBehavior: Clip.antiAlias,
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Configurations"),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "level: ${result.level}\nmode: ${result.game_mode}\nweight: ${result.predict_weight_path}\ngame_time: ${result.game_time}\ntrials: ${result.trial_number}",
                                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                  ),
                                )
                              ]
                            )
                          ),
                          SizedBox(
                            width: 10
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Score Stats"),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "mean: ${result.mean_score_string}\nstddev: ${result.stddev_score_string}\nmax: ${result.max_score}\nmin: ${result.min_score}",
                                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                  ),
                                )
                              ]
                            )
                          ),
                        ]
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: _screenSize.height*0.5,
                        child: Column(
                          children: [
                            Text("Details"),
                            Expanded(
                              child: ResultDetailTable.ResultDetailTable(result)
                            ),
                          ]
                        )
                      )
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
                // Image.asset('assets/card-sample-image.jpg'),
                // Image.asset('assets/card-sample-image-2.jpg'),
              ],
            ),
          ),
        )
      );
    },
  );
}

