import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';

import '../../model/form_model.dart';
import '../../model/score_evaluation_message.pb.dart';
import '../../view_model/providers.dart';

class SubmitForm extends HookConsumerWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _screenSize = MediaQuery.of(context).size;
    final _userNameFormController = useTextEditingController();
    final _repositoryNameFormController = useTextEditingController(text: "tetris");
    final _branchFormController = useTextEditingController(text: "master");
    final _levelFormController = useTextEditingController(text: "1");
    final _formCardHeight = _screenSize.height * 0.15;
    final _formCardWidth = _screenSize.width * 0.5;
    final _state = ref.watch(formStateNotifierProvider.notifier).state;

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
              child: ElevatedButton(
                onPressed: () {
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
                },
                child: const Text("Submit"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
