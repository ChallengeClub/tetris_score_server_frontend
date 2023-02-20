import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';

import 'package:fixnum/fixnum.dart' as $fixnum;

import '../../view_model/providers.dart';

class RanomSeedForm extends HookConsumerWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _state = ref.watch(randomSeedsFormStateNotifierProvider);
    final _randomSeedController = useTextEditingController(text: "");
    Size ui_size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.only(left: ui_size.width*0.02, right: ui_size.width*0.02),
        child: Column(
          children: <Widget>[   
            Row(
              children: <Widget>[
                SizedBox(
                  width: ui_size.width*0.3,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'random seeds',
                    ),
                    controller: _randomSeedController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      $fixnum.Int64 x;
                      try {
                        x = $fixnum.Int64(int.parse(value));
                      } catch (e) {
                        return 'Please enter Int64 castable value';
                      }
                      if (x<0) {
                        return 'Please enter positive value';
                      }
                      return null;
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add_box),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ref.read(randomSeedsFormStateNotifierProvider.notifier).addSeed(
                        $fixnum.Int64(int.parse(_randomSeedController.text))
                      );
                    }
                  },        
                ),
              ]
            ),
            Container(
              height: _state.seeds.length*30,
              child: ListView.builder(
                itemCount: _state.seeds.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 30,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text('${index+1}', style: TextStyle(fontSize: 10,)),
                        SizedBox(width: ui_size.width*0.05,),
                        SizedBox(
                          width: ui_size.width*0.2,
                          child: Text('${_state.seeds[index]}', style: TextStyle(fontSize: 15,))
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, size: 20),
                          onPressed: () {
                            ref.read(randomSeedsFormStateNotifierProvider.notifier).removeSeedAt(index);
                          },
                        ),
                      ]
                    )
                  );
                }
              ),
            ),
          ]
        )
      )
    );
  }
}