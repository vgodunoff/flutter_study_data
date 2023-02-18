import 'package:flutter/cupertino.dart';
import 'package:flutter_study_data/work_with_net/domain/api_clients/api_client.dart';

import '../../domain/entity/post.dart';

//предоставляет данные которые мы будем отображать
// так как инхерит должен быть типа лисэнэбл - <T extends Listenable>
// а именно abstract class InheritedNotifier<T extends Listenable>
//то нашу модель унаследуем от ChangeNotifier
//потому что class ChangeNotifier implements Listenable
class ExampleWidgetModel extends ChangeNotifier {
  var _posts = <Post>[];
  List<Post> get posts => _posts;
  final apiClient = ApiClient();

  Future<void> reloadPosts() async {
    final posts = await apiClient.getPost();
    _posts.clear();
    _posts +=
        posts; // так тоже можно добавлять в список, идет замена старых новыми
    print(_posts.length);
    notifyListeners();
  }

  Future<void> createPosts() async {
    final post = apiClient.createPost(title: 'sdfg', body: 'стол');
  }
}

class ExampleModelProvider extends InheritedNotifier {
  final ExampleWidgetModel model;
  const ExampleModelProvider(
      {Key? key, required Widget child, required this.model})
      : super(key: key, notifier: model, child: child);

  static ExampleModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ExampleModelProvider>();
  }

  static ExampleModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<ExampleModelProvider>()
        ?.widget;

    return widget is ExampleModelProvider ? widget : null;
  }
}
