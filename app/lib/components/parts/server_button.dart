import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

class ServerButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(60),
          onTap: () => context.push('/server/v5'),
          child: const SizedBox(
            width: 300,
            height: 100,
            child: Center(
              child:Text('Server'),)
          ),
        ),
    ));
  }
}
