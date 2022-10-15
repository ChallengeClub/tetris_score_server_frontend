import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';

import '../../model/form_model.dart';
import '../../view_model/providers.dart';

class SubmitForm extends HookConsumerWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _screenSize = MediaQuery.of(context).size;
    final _urlFormController = useTextEditingController();
    final _branchFormController = useTextEditingController(text: "master");
    final _levelFormController = useTextEditingController(text: "1");
    final _formCardHeight = _screenSize.height * 0.15;
    final _formCardWidth = _screenSize.width * 0.5;
    final _state = ref.watch(formStateNotifierProvider.notifier);

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
                      labelText: 'repository url *',
                    ),
                    controller: _urlFormController,
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
                      labelText: 'branch name (default: master)',
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
                      labelText: 'game level (default: 1)',
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
                      _urlFormController.text,
                      _branchFormController.text,
                      _levelFormController.text,
                    )
                  );
                },
                child: const Text("submit"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
