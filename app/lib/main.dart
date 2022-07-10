import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// providerのgolabal宣言
final formProvider = Provider((_) => 0);

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int value = ref.watch(formProvider);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref){
    final int value = ref.watch(formProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Tetris評価サーバ"),
      ),
      body: Center(
        child: Text(value.toString())
      ),
    );
  }
    
  }
