import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// providerのgolabal宣言
final formProvider = Provider((_) => 0);

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tetris評価サーバ"),
      ),
      body: Center(
        child: Container(margin: const EdgeInsets.all(40), child: SubmitForm()),
      ),
    );
  }
}

class SubmitForm extends ConsumerWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _screenSize = MediaQuery.of(context).size;
    final _formCardHeight = _screenSize.height * 0.12;
    final _formCardWidth = _screenSize.width * 0.4;
    return Form(
      key: _formKey,
      child: Container(
        width: _screenSize.width * 0.6,
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
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
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
