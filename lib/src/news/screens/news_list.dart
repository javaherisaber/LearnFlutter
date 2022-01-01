import 'package:flutter/material.dart';
import 'package:learn/src/news/blocs/stories_provider.dart';
import 'package:learn/src/news/widgets/news_list_tile.dart';
import 'package:learn/src/news/widgets/refresh.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    // THIS IS BAD!!!!! DONT DO THIS TEMPORARY!
    bloc.fetchTopIds();

    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Refresh(
          child: ListView.builder(
            itemCount: snapshot.requireData.length,
            itemBuilder: (context, int index) {
              bloc.fetchItem(snapshot.requireData[index]);

              return NewsListTile(itemId: snapshot.requireData[index]);
            },
          ),
        );
      },
    );
  }
}
