import 'package:flutter/material.dart';
import 'package:learn/src/news/blocs/comments_bloc.dart';

export 'comments_bloc.dart';

class CommentsProvider extends InheritedWidget {
  final bloc = CommentsBloc();

  CommentsProvider({super.key, required super.child});

  @override
  bool updateShouldNotify(_) => true;

  static CommentsBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CommentsProvider>()!.bloc;
  }
}