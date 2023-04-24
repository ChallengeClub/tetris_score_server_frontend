import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:go_router/go_router.dart';

import '../../model/result_model.dart';
import '../../model/results_table_model.dart';
import '../../view_model/providers.dart';

class TableNavigator extends HookConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ResultsTableModel _results_table = ref.watch(resultsTableStateNotifierProvider);

    return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
            IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: _results_table.results.length>0 ? 
                    () => ref.read(resultsTableStateNotifierProvider.notifier).refresh() : null
            ),
            IconButton(
                icon: const Icon(Icons.navigate_before),
                onPressed: _results_table.is_before_page_enabled ? 
                    () => ref.read(resultsTableStateNotifierProvider.notifier).moveToBeforePage() : null
            ),
            Text(_results_table.page.toString()),
            IconButton(
                icon: const Icon(Icons.navigate_next),
                onPressed: _results_table.is_next_page_enabled ? 
                    () => ref.read(resultsTableStateNotifierProvider.notifier).moveToNextPage() : null
            ),
        ]
    );
  }
}