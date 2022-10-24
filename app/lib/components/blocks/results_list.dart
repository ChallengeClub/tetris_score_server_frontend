import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';

import '../../view_model/providers.dart';
import '../parts/result_card.dart';

class ResultsList extends HookConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _screenSize = MediaQuery.of(context).size;
    final _formCardHeight = _screenSize.height * 0.11;
    final _formCardWidth = _screenSize.width * 0.5;
    final _state = ref.watch(resultStateNotifierProvider.notifier).state;
    return ListView.builder(
      itemCount: _state.length, 
      itemBuilder: (BuildContext context, int index) {
        return Container(
            child: ResultsCard(result: _state[index])
        );
      },
    );
  }
}