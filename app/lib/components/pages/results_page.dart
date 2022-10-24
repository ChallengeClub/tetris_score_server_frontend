import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../blocks/results_list.dart';

class ResultsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Container(margin: const EdgeInsets.all(40), child: ResultsList()),
      ),
    );
  }
}
