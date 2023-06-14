import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

class CompetitionButton extends ConsumerWidget {
  final String _competition = "v5";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(60),
          onTap: () => context.push('/entry/${_competition}'),
          child: SizedBox(
            width: 300,
            height: 130,
            child: Center(
              child:Text('Entry'),
            )
          ),
        ),
      )
    );
  }
}