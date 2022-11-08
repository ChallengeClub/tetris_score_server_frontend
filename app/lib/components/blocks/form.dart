import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';

import '../../model/form_model.dart';
import '../../model/score_evaluation_message.pb.dart';
import '../../view_model/providers.dart';
import '../../view_model/form_state_notifier.dart' as form;

class SubmitForm extends HookConsumerWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _screenSize = MediaQuery.of(context).size;
    final _userNameFormController = useTextEditingController();
    final _repositoryNameFormController = useTextEditingController(text: "tetris");
    final _branchFormController = useTextEditingController(text: "master");
    final _levelFormController = useTextEditingController(text: "1");
    final _formCardHeight = _screenSize.height * 0.11;
    final _formCardWidth = _screenSize.width * 0.5;
    final _state = ref.watch(formStateNotifierProvider);

    return Form(
      key: _formKey,
      child: Container(
        width: _screenSize.width * 0.7,
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
                    autofocus: true,
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
            ),Card(
              color: Theme.of(context).colorScheme.surfaceVariant,
              child: Center(
                child: SizedBox(
                  width: _formCardWidth,
                  height: _formCardHeight,
                  child: TextFormField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: 'repository name',
                    ),
                    controller: _repositoryNameFormController,
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ((){
                if (_state is form.FormInitial){
                  return ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) { // validate form data when button pressed
                        ref.read(formStateNotifierProvider.notifier).submitMessage(
                          FormModel(
                            _userNameFormController.text,
                            _repositoryNameFormController.text,
                            _branchFormController.text,
                            1000,
                            int.parse(_levelFormController.text),
                            "default",
                            180,
                            185,
                            "",
                            10
                          )
                        );
                      }
                    },
                    child: const Text("Submit"),
                  );
                } else if (_state is form.FormSubmitting){
                  return CircularProgressIndicator();
                } else if (_state is form.FormSubmitted){
                  return Text("form successfully submitted");
                } else if (_state is form.FormError){
                  return Text(_state.message);
                } else {
                 return Text("unexpected error occured\n${_state}");
                }
              })(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0),
              child: ((){
                if (_state is form.FormError || _state is form.FormSubmitted){
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
    );
  }
}
