import 'dart:convert';
import 'dart:io';

import '../entity/post.dart';

class ApiClient {
  final client = HttpClient();

  //по идее метод должен быть void
  Future<Post?> createPost(
      {required String title, required String body}) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final parameters = <String, dynamic>{
      'title': title,
      'body': body,
      'userId': 109
    };
    final request = await client.postUrl(url);
    request.headers.set('Content-type', 'application/json; charset=UTF-8');
    request.write(jsonEncode(parameters));
    final response = await request.close();

    //ниже мы код не обязателен/не нужен для метода пост, в нашем случае пост запрос фейковый
    //просто получаем из запроса снова джсон чтобы отразить что же мы отправили на
    // сервер
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();

    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    print(jsonString);
    return null;
  }

  Future<List<Post>> getPosts() async {
    //

    //Uri(scheme: 'https', host: 'jsonplaceholder.typicode.com', path: 'posts');

    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final request = await client.getUrl(url);
    //полученный реквест можно еще донастроить, пока он еще никуда не ушел
    //применяем к нему метод close() и этот метод начинает выполняться
    //то есть он отправляется на сервер
    final response = await request.close();
    // у response можно посмотреть headers, statusCode
    //в данном response нет body как в пакете http
    //здесь мы имеем на выходе стрим Stream<List<int>> списки байт
    //в этих массивах байт может быть закодированы разные штуки, например,
    //изображения или текстовый файл
    /*
  наш джсон мы получили за 10 раз, 10 кусков с байтами
  мы будем использовать метод стрима transform() и получим стрим строк

  transform(utf8.decoder)
  */
    //из стрима int делаем список строк
    final jsonStrings = await response.transform(utf8.decoder).toList();
    // из массива делаем одну строку
    final jsonString = jsonStrings.join();
// строку джсон превращаем в массив объектов
    final json = jsonDecode(jsonString) as List<dynamic>;
//конструируем объекты класса Пост
    final posts =
        json.map((e) => Post.fromJson(e as Map<String, dynamic>)).toList();
    return posts;
  }

  Future<dynamic> get(String url) async {
    final uri = Uri.parse(url);
    final request = await client.getUrl(uri);
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final dynamic json = jsonDecode(jsonString);
    return json;
  }

  Future<List<Post>> getPost() async {
    final json = await get('https://jsonplaceholder.typicode.com/posts')
        as List<dynamic>;
    final posts =
        json.map((e) => Post.fromJson(e as Map<String, dynamic>)).toList();
    return posts;
  }
}
