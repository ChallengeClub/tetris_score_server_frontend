import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

class ServerButton extends ConsumerWidget {
  final String _competition = "v5";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/results_table.jpg'),
            fit: BoxFit.fitWidth,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey, //色
              spreadRadius: 1, 
              blurRadius: 5, 
              offset: Offset(2, 2),
            ),
          ],
        ),
        width: 300,
        height: 150,
        child: InkWell( // required for onTap action
          onTap: () => context.push('/server/${_competition}'),
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
            child: Text("Score Server", style: const TextStyle(color: Colors.white70, fontSize: 15)),
          ),
        )
      ),
    );
  }
}
