import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

class TrainingButton extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Container(
        width: 300,
        height: 150,
        child: InkWell( // required for onTap action
          onTap: () => context.push('/trainings'),
          child: Container(
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black,
                ],
              ),
            ),
            child: Text("Trainings", style: const TextStyle(color: Colors.white70, fontSize: 15)),
          ),
        )
      ),
    );
  }
}