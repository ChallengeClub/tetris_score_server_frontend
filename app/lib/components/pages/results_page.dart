import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../blocks/results_table.dart';

class ResultsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: ResultsTable(),
      ),
    );
  }
}
