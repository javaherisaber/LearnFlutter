import 'package:flutter/material.dart';
import 'package:learn/src/news/blocs/stories_provider.dart';

class Refresh extends StatelessWidget {
  Refresh({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await bloc.clearCache();
        await bloc.fetchTopIds();
      },
    );
  }
}
