import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';


import '../../model/training_form_model.dart';
import '../../view_model/training_form_view_model.dart';
import '../../view_model/providers.dart';
import '../parts/training_sample_field.dart';
import '../parts/training_input_output_sample.dart';
import '../parts/training_subhead.dart';
import '../parts/training_answer_example.dart';
import '../blocks/custom_appbar.dart';
import '../blocks/user_menu_drawer.dart';

class TrainingAlgorithmPage extends HookConsumerWidget {
  final String _id;
  TrainingAlgorithmPage(this._id);
  final TextEditingController _codeEditingController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TrainingFormModel _state = ref.watch(trainingFormStateNotifierProvider(TrainingModel("algorithm", _id, null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)));
    Size _size = MediaQuery.of(context).size;
    
    // 初期値を設定
    useEffect(() {
      if (_state.training.initialFormValue != null) {
        _codeEditingController.text = _state.training.initialFormValue!;
      }
    }, [_state.training.initialFormValue]);

    return SelectionArea(
      child: Scaffold(
        appBar: CustomAppbar(title: const Text('Tetris Training Page')),
        endDrawer: UserMenuDrawer(),
        body: SingleChildScrollView(
          child: ((){
            if (_state.status=="initializing"){
              return Center(
                child: CircularProgressIndicator.adaptive()
              );              
            } else {
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
                          child: Text(_state.training.title ?? "", style: TextStyle(fontSize: 24)),
                        ),
                        TrainingSubhead("Problem Statement"),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                          child: Text(_state.training.description ?? "", style: TextStyle(fontSize: 12)),
                        ),
                        TrainingSubhead("Input"),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(_state.training.inputDescription ?? "", style: TextStyle(fontSize: 12)),
                          ),
                        ),
                        TrainingSampleField(_state.training.inputTemplate, false),
                        TrainingSubhead("Output"),
                        TrainingSampleField(_state.training.outputTemplate, false),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                            child: Text(_state.training.outputDescription ?? "", style: TextStyle(fontSize: 12)),
                          ),
                        ),
                        TrainingSubhead("Constraints"),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                            child: Text(_state.training.constraints ?? "", style: TextStyle(fontSize: 12)),
                          ),
                        ),
                        TrainingInputOutputSample("InputSample", _state.training.inputSample, true),
                        TrainingInputOutputSample("OutputSample", _state.training.outputSample, true),
                        (() {
                          if (_state.training.sampleDescription==null){
                            return SizedBox(height: 0);
                          } else {
                            return Container(
                              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                child: Text(_state.training.sampleDescription!, style: TextStyle(fontSize: 12)),
                              ),
                            );
                          }
                        })(),
                        TrainingInputOutputSample("InputSample2", _state.training.inputSample2, true),
                        TrainingInputOutputSample("OutputSample2", _state.training.outputSample2, true),
                        (() {
                          if (_state.training.sampleDescription2==null){
                            return SizedBox(height: 0);
                          } else {
                            return Container(
                              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                child: Text(_state.training.sampleDescription2!, style: TextStyle(fontSize: 12)),
                              ),
                            );
                          }
                        })(),
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
                            style: TextStyle(fontSize: 10)
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
                            if (_state.status=="initialized"){
                              return Container(
                                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_codeEditingController.text==""){
                                      ref.read(trainingFormStateNotifierProvider.call(_state.training).notifier).setFormValidationErrorState();
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
                                                  ref.read(trainingFormStateNotifierProvider.call(_state.training).notifier).submitAlgorithmCode(
                                                      _codeEditingController.text,
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
                            } else if (_state.status=="submitting" || _state.status=="initializing"){
                              return CircularProgressIndicator();
                            } else if (_state.status=="finished"){
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Reulsts", style: TextStyle(fontSize: 15)),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                                    height: 200,
                                    child: ListView.builder(
                                      itemCount: _state.results!.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        String result = _state.results![index];
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
                            } else if (_state.status=="error"){
                              return Text(_state.error_message ?? "");
                            } else {
                              return Text("unexpected error occured\n${_state}");
                            }
                          })()
                        ),
                        TrainingSubhead("Answer Example"),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: TrainingAnswerExample(_state.status!, _state.training.answerExample ?? ""),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          child: ((){
                            if (_state.status=="error" || _state.status=="finished"){
                              return ElevatedButton(
                                onPressed: (){
                                  ref.read(trainingFormStateNotifierProvider.call(_state.training).notifier).initializeState();
                                },
                                child: const Text("Reset"),
                              );
                            } 
                          })(),
                        ),
                      ]
                    )
                  ),
                ]
              );
            }
          })(),
        )
      )
    );
  }
}

