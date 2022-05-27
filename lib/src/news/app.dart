import 'package:flutter/material.dart';
import 'package:learn/src/news/blocs/comments_provider.dart';
import 'package:learn/src/news/blocs/stories_provider.dart';
import 'package:learn/src/news/screens/news_detail.dart';
import 'package:learn/src/news/screens/news_list.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: 'News!',
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
          final bloc = StoriesProvider.of(context);
          bloc.fetchTopIds();
          return NewsList();
        },
      );
    } else {
      return MaterialPageRoute(builder: (context) {
        final commentsBloc = CommentsProvider.of(context);
        final itemId = int.parse(settings.name!.replaceFirst('/', ''));

        commentsBloc.fetchItemWithComments(itemId);

        return NewsDetail(itemId);
      });
    }
  }
}
