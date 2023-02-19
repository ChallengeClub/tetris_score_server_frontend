import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';

import 'package:fixnum/fixnum.dart' as $fixnum;

import '../../view_model/providers.dart';

class RanomSeedForm extends HookConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _state = ref.watch(randomSeedsFormStateNotifierProvider);
    final _randomSeedController = useTextEditingController(text: "");
    Size ui_size = MediaQuery.of(context).size;
    double ui_height = ui_size.height;
    double ui_width = ui_size.width;

    return Column(
      children: <Widget>[   
        Row(
          children: <Widget>[
            SizedBox(
              width: ui_width*0.3,
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'random seeds',
                ),
                controller: _randomSeedController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.add_box),
              onPressed: () {
                ref.read(randomSeedsFormStateNotifierProvider.notifier).addSeed(
                  $fixnum.Int64(int.parse(_randomSeedController.text))
                );
              },        
            ),
          ]
        )
        // Expanded(
        //   child: ListView.builder(
        //     itemCount: _state.length,
        //     itemBuilder: (context, index) {
        //       return Card(
        //         child: ListTile(
        //           title: Text('${_state[index]}'),
        //           trailing: IconButton(
        //             icon: Icon(Icons.delete),
        //             onPressed: () {
        //               ref.read(randomSeedsFormStateNotifierProvider.notifier).removeSeedAt(index);
        //             },
        //           ),
        //         ),
        //       );
        //     }
        //   ),
        // )
      ]
    ); 
  }
}