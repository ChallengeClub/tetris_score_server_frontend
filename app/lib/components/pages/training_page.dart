import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';


import '../../model/training_form_model.dart';
import '../../view_model/training_form_view_model.dart';
import '../../view_model/providers.dart';
import '../parts/training_sample_field.dart';

class TrainingPage extends HookConsumerWidget {
  final String _section;
  final String _id;
  TrainingPage(this._section, this._id);
  final TextEditingController _codeEditingController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TrainingModel? _training = ref.watch(trainingDetailStateNotifierProvider);
    ref.read(trainingDetailStateNotifierProvider.notifier).fetchTrainingDetail(_section, _id);
    TrainingFormState _state = ref.watch(trainingFormStateNotifierProvider(TrainingModel(_section, _id, "", "", "", "")));
    Size _size = MediaQuery.of(context).size;

    return SelectionArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Tetris Training Page')),
        body: SingleChildScrollView(
          child: ((){
            if (_training==null){
              return Column(
                children: [
                  Container(
                    width: _size.width > 700 ? 700 : _size.width,
                    padding: EdgeInsets.symmetric(vertical: _size.height*0.02, horizontal: _size.width*0.05),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Text("倍返しだ！", style: TextStyle(fontSize: 24)),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Text("Problem Statement", style: TextStyle(fontSize: 15)),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                          child: Text("与えられた数字Xに2をかけた数字を出力してください。", style: TextStyle(fontSize: 10)),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Text("Input", style: TextStyle(fontSize: 15)),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text("入力は以下の形式で標準入力から与えられる。", style: TextStyle(fontSize: 10)),
                          ),
                        ),
                        TrainingSampleField("X", false),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Text("Output", style: TextStyle(fontSize: 15)),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                            child: Text("Xに2をかけた値をprintしてください。", style: TextStyle(fontSize: 10)),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Text("Input Sample", style: TextStyle(fontSize: 15)),
                        ),
                        TrainingSampleField("2", true),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Text("Output Sample", style: TextStyle(fontSize: 15)),
                        ),
                        TrainingSampleField("4", true),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Text("Source Code", style: TextStyle(fontSize: 15)),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: TextField(
                            enabled: true,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            expands: true,
                            controller: _codeEditingController,
                            style: TextStyle(fontSize: 12)
                          ),
                          height: _size.height*0.4,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: ((){
                            if (_state is TrainingFormInitial){
                              return Container(
                                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_codeEditingController.text==""){
                                      ref.read(trainingFormStateNotifierProvider.call(_training!).notifier).setFormValidationErrorState();
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text("Are you sure to submit code?"),
                                            actions: [
                                              TextButton(
                                                child: Text("Cancel"),
                                                onPressed: () => Navigator.pop(context),
                                              ),
                                              TextButton(
                                                child: Text("OK"),
                                                onPressed: () {
                                                  ref.read(trainingFormStateNotifierProvider.call(_training!).notifier).submitCode(
                                                    TrainingFormModel(
                                                      "test_user",
                                                      _training!,
                                                      _codeEditingController.text,
                                                    )
                                                  );
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                  child: const Text("Submit"),
                                )
                              );
                            } else if (_state is TrainingFormSubmitting){
                              return CircularProgressIndicator();
                            } else if (_state is TrainingEvaluationFinished){
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Reulsts", style: TextStyle(fontSize: 15)),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                                    height: 200,
                                    child: ListView.builder(
                                      itemCount: _state.results.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        String result = _state.results[index];
                                        return Container(
                                          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                          child: Row(
                                            children:[
                                              Text(index.toString()),
                                              SizedBox(width: 10),
                                              ElevatedButton(
                                                onPressed: (){},
                                                child: Text(result, style:TextStyle(color: Colors.white)),
                                                style: ElevatedButton.styleFrom(
                                                  primary: ((){
                                                    if (result=="AC"){
                                                      return Colors.green;
                                                    } else {
                                                      return Colors.orange;
                                                    }
                                                  })(),
                                                ),
                                              )
                                            ]
                                          )
                                        );
                                      },
                                    )
                                  )
                                ]
                              );
                            } else if (_state is TrainingFormError){
                              return Text(_state.message);
                            } else {
                              return Text("unexpected error occured\n${_state}");
                            }
                          })()
                        ),
                        Container(
                          child: ((){
                            if (_state is TrainingFormError || _state is TrainingEvaluationFinished){
                              return ElevatedButton(
                                onPressed: (){
                                  ref.read(trainingFormStateNotifierProvider.call(_training!).notifier).initializeState();
                                },
                                child: const Text("OK"),
                              );
                            } 
                          })(),
                        ),
                      ]
                    )
                  ),
                ]
              );
            } else {
              return CircularProgressIndicator.adaptive();
            }
          })(),
        )
      )
    );
  }
}

