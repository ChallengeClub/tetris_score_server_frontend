import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';

import '../../model/form_model.dart';
import '../../model/score_evaluation_message.pb.dart';
import '../parts/random_seed_form.dart';
import '../../view_model/providers.dart';
import '../../view_model/form_view_model.dart' as FormViewModel;

class SubmitForm extends HookConsumerWidget {
  final String _competition;
  SubmitForm(this._competition);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _screenSize = MediaQuery.of(context).size;
    final _userNameFormController = useTextEditingController(text: "");
    final _repositoryURLFormController = useTextEditingController(text: "https://github.com/seigot/tetris");
    final _branchFormController = useTextEditingController(text: "master");
    final _levelFormController = useTextEditingController(text: "1");
    final _predictWeightPathController = useTextEditingController(text: "");
    final _trialNumberController = useTextEditingController(text: "1");
    final _gameModeController = useTextEditingController(text: "default");
    final _gameTimeController = useTextEditingController(text: "180");
    final _competitionController = useTextEditingController(text: _competition);
    final _formCardHeight = _screenSize.height * 0.11;
    final _formCardWidth = _screenSize.width * 0.5;
    final _state = ref.watch(formStateNotifierProvider);
    final _random_seeds_state = ref.watch(randomSeedsFormStateNotifierProvider);

    return Form(
      key: _formKey,
      child: Container(
        width: _screenSize.width * 0.7,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: Center(
                  child: SizedBox(
                    width: _formCardWidth,
                    height: _formCardHeight,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'user name',
                      ),
                      controller: _userNameFormController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              Card(
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: Center(
                  child: SizedBox(
                    width: _formCardWidth,
                    height: _formCardHeight,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'github repository URL',
                      ),
                      controller: _repositoryURLFormController,
                      validator: (String? value) {
                        String? res = ref.read(formStateNotifierProvider.notifier).checkRepositoryURLPattern(value);
                        return res;
                      },
                    ),
                  ),
                ),
              ),
              Card(
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: Center(
                  child: SizedBox(
                    width: _formCardWidth,
                    height: _formCardHeight,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'branch name',
                      ),
                      controller: _branchFormController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              Card(
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: Center(
                  child: SizedBox(
                    width: _formCardWidth,
                    height: _formCardHeight,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'game level',
                      ),
                      controller: _levelFormController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        List levels = ["1", "2", "3"];
                        if (!levels.contains(value)) {
                          return 'Value must be in ${levels}';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: Card(
                  child: ExpansionTile(
                    title: Text('options'),
                    controlAffinity: ListTileControlAffinity.leading,
                    maintainState: true,
                    children: <Widget>[
                      Center(
                        child: SizedBox(
                          width: _formCardWidth,
                          height: _formCardHeight,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'game mode ["default", "predict", "predict_sample", "predict_sample2"]',
                            ),
                            controller: _gameModeController,
                            validator: (String? value) {
                              List game_modes = ["default", "predict", "predict_sample", "predict_sample2"];
                              if (!game_modes.contains(value)) {
                                return 'must be in ${game_modes}';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: _formCardWidth,
                          height: _formCardHeight,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'predict weight path',
                            ),
                            controller: _predictWeightPathController,
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: _formCardWidth,
                          height: _formCardHeight,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'game time',
                            ),
                            controller: _gameTimeController,
                            validator: (String? value) {
                              if (value==null){
                                return 'please input positive integer';
                              }
                              int game_time = int.tryParse(value) ?? 0;
                              if (game_time<=0) {
                                return 'please input positive integer';
                              } else if (game_time>180){
                                return 'game time cannot be more than 180 s';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: _formCardWidth,
                          height: _formCardHeight,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'trial number',
                            ),
                            controller: _trialNumberController,
                            validator: (String? value) {
                              if (value==null){
                                return 'please input positive integer, 1<=N<=10';
                              }
                              int trials = int.tryParse(value) ?? 0;
                              if (trials<=0) {
                                return 'please input positive integer, 1<=N<=10';
                              } else if (trials>10){
                                return 'trial number cannot be more than 10 ;;';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: _formCardWidth,
                          height: _formCardHeight,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'competition(fixed)',
                            ),
                            controller: _competitionController,
                            enabled: false,
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: _formCardWidth,
                          child: Row(
                            children: <Widget>[
                              Text("seed configuration"),
                              Checkbox(
                                activeColor: Colors.blue,
                                value: _random_seeds_state.isEnabledSeedConfiguration,
                                onChanged: ref.read(randomSeedsFormStateNotifierProvider.notifier).toggleIsEnabled,
                              ),
                            ]
                          ),
                        )
                      ),
                      ((){
                        if (_random_seeds_state.isEnabledSeedConfiguration){
                          return Center(
                            child: SizedBox(
                              width: _formCardWidth,
                              child: RanomSeedForm()
                            )
                          );
                        }
                        else{
                          return SizedBox();
                        }
                      })(),
                      SizedBox(
                        height: 30
                      ),
                    ],
                  )
                )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ((){
                  if (_state is FormViewModel.FormInitial){
                    return ElevatedButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {// validate form data when button pressed
                          ref.read(formStateNotifierProvider.notifier).setFormValidationErrorState();
                          return;
                        }
                        if (_random_seeds_state.isEnabledSeedConfiguration && (int.parse(_trialNumberController.text)!=_random_seeds_state.seeds.length)){
                          ref.read(formStateNotifierProvider.notifier).setRandomFormValidationErrorState();
                          return;
                        }
                        ref.read(formStateNotifierProvider.notifier).submitMessage(
                          FormModel(
                            _userNameFormController.text,
                            _repositoryURLFormController.text,
                            _branchFormController.text,
                            1000,
                            int.parse(_levelFormController.text),
                            _gameModeController.text,
                            int.parse(_gameTimeController.text),
                            185,
                            _predictWeightPathController.text,
                            int.parse(_trialNumberController.text),
                            _random_seeds_state.seeds,
                            _competitionController.text,
                          )
                        );
                      },
                      child: const Text("Submit"),
                    );
                  } else if (_state is FormViewModel.FormSubmitting){
                    return CircularProgressIndicator();
                  } else if (_state is FormViewModel.FormSubmitted){
                    return Text("form successfully submitted");
                  } else if (_state is FormViewModel.FormError){
                    return Text(_state.message);
                  } else {
                    return Text("unexpected error occured\n${_state}");
                  }
                })(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: ((){
                  if (_state is FormViewModel.FormError || _state is FormViewModel.FormSubmitted){
                    return ElevatedButton(
                      onPressed: (){
                        ref.read(formStateNotifierProvider.notifier).initializeState();
                      },
                      child: const Text("OK"),
                    );
                  } 
                })(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
