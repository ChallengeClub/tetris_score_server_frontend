import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../view_model/providers.dart';

class CustomAppbar extends ConsumerWidget implements PreferredSizeWidget {
  final Text title;
  final TabBar? bottom;

  CustomAppbar({this.title = const Text(""), this.bottom});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(userLoginStateNotifierProvider); // this part is only for call auth configure method
    return AppBar(
      title: title,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));
}
