import 'package:flutter/material.dart';
import 'package:learn/src/news/blocs/stories_provider.dart';
import 'package:learn/src/news/screens/news_list.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: MaterialApp(
        title: 'News!',
        home: NewsList(),
      ),
    );
  }
}