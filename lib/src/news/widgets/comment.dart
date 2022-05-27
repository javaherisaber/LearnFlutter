import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:learn/src/news/widgets/loading_container.dart';

import '../models/item_model.dart';

class Comment extends StatelessWidget {
  const Comment({required this.depth, required this.itemId, required this.itemMap, super.key});

  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ItemModel>(
      future: itemMap[itemId],
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }
        final item = snapshot.requireData;
        final children = <Widget>[
          ListTile(
            title: Html(data: item.text),
            subtitle: item.by == '' ? Text('Deleted') : Text(item.by),
            contentPadding: EdgeInsets.only(left: (depth + 1) * 16, right: 16),
          ),
          Divider(),
        ];
        item.kids.forEach((kidId) {
          children.add(Comment(itemId: kidId, itemMap: itemMap, depth: this.depth + 1));
        });

        return Column(
          children: children,
        );
      },
    );
  }
}
