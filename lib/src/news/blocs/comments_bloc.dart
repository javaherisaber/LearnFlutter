import 'package:learn/src/news/models/item_model.dart';
import 'package:learn/src/news/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class CommentsBloc {
  CommentsBloc() {
    _commentsFetcher.stream.transform(_commentsTransformer()).pipe(_commentsOutput);
  }

  final _repository = Repository();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  Stream<Map<int, Future<ItemModel>>> get itemWithComments => _commentsOutput.stream;

  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  _commentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
      (cache, int id, index) {
        cache[id] = _repository.fetchItem(id);
        cache[id]?.then((ItemModel item) {
          item.kids.forEach((kidId) => fetchItemWithComments(kidId));
        });
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  void dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}
