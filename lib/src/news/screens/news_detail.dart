import 'package:flutter/material.dart';
import 'package:learn/src/news/blocs/comments_provider.dart';
import 'package:learn/src/news/models/item_model.dart';
import 'package:learn/src/news/widgets/comment.dart';

class NewsDetail extends StatelessWidget {
  const NewsDetail(this.itemId, {Key? key}) : super(key: key);

  final int itemId;

  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder<Map<int, Future<ItemModel>>>(
      stream: bloc.itemWithComments,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text('Loading...'),
          );
        }
        final itemFuture = snapshot.requireData[itemId];
        return FutureBuilder<ItemModel>(
          future: itemFuture,
          builder: (context, itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return Text('Loading...');
            }
            return buildList(itemSnapshot.requireData, snapshot.requireData);
          },
        );
      },
    );
  }

  Widget buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    final comments = item.kids.map((kidId) {
      return Comment(itemId: kidId, itemMap: itemMap, depth: 0);
    }).toList();
    return ListView(
      children: [
        buildTitle(item),
        ...comments
      ],
    );
  }

  Widget buildTitle(ItemModel item) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(10.0),
      child: Text(
        item.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
