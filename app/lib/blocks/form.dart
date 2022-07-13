import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/form_model.dart';

class SubmitForm extends HookWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    // final _formController = useTextEditingController.fromValue(TextEditingValue.fromJSON(formData.toMap()));
    final _formController = useTextEditingController(text: 'initial text');
    final _formCardHeight = _screenSize.height * 0.1;
    final _formCardWidth = _screenSize.width * 0.5;
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
                    decoration: const InputDecoration(
                      labelText: 'repository url *',
                    ),
                    // controller: _formController,
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
                      hintText: 'master',
                    ),
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
                      labelText: 'drop interval (default: 1000)',
                      hintText: '1000',
                    ),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  print(_formController.toString());
                  if (_formKey.currentState!.validate()) {
                    // Process data.
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
