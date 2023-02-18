import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_study_data/work_with_json/example_data.dart';
import 'package:flutter_study_data/work_with_json/human.dart';

/*
Согласно документации https://docs.flutter.dev/development/data-and-backend/
json#setting-up-json_serializable-in-a-project
применяются два подхода работы с джсон - вручную или генерация кода автоматически
в доках не указывается, но также есть онлайн сервисы по формированию классов-моделей
из джсон, например https://app.quicktype.io/

Encoding and serialization are the same thing—turning a data structure into a 
string. Decoding and deserialization are the opposite process—turning a string 
into a data structure. However, serialization also commonly refers to the entire 
process of translating data structures to and from a more easily readable format.

To avoid confusion, this doc uses “serialization” when referring to the overall 
process, and “encoding” and “decoding” when specifically referring to those 
processes.

Когда делаем вручную то можно сразу использовать полученные данные
например из мапы
Map<String, dynamic> user = jsonDecode(jsonString);

print('Howdy, ${user['name']}!');
print('We sent the verification link to ${user['email']}.');


второй вариант, предполагает "распарсить джсон" с помощью модели (класса)
class User {
  final String name;
  final String email;

  User(this.name, this.email);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      };
}

и третий вариант с использованием дополнительных библиотек для автоматической генерации
конструктора fromJson и метода toJson
dependencies:
  # Your other regular dependencies here
  json_annotation: <latest_version>

dev_dependencies:
  # Your other dev_dependencies here
  build_runner: <latest_version>
  json_serializable: <latest_version>

*/

class ExampleJson extends StatelessWidget {
  const ExampleJson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: JsonExampleProvider(
            coder: JsonExampleCoder(), child: const ButtonWidget()),
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () => JsonExampleProvider.read(context)?.coder.encode(),
            child: const Text('Кодировать')),
        ElevatedButton(
            onPressed: () => JsonExampleProvider.read(context)?.coder.decode(),
            child: const Text('Декодировать'))
      ],
    );
  }
}

/*
JsonExampleProvider в нашем примере используется для передачи 
объекта класса JsonExampleCoder coder, у которого есть методы
работы с json, перевод из json-строки в объект и наоборот
*/
class JsonExampleProvider extends InheritedWidget {
  final JsonExampleCoder coder;

  const JsonExampleProvider({
    Key? key,
    required this.coder,
    required Widget child,
  }) : super(key: key, child: child);

  static JsonExampleProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<JsonExampleProvider>();
  }

  static JsonExampleProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<JsonExampleProvider>()
        ?.widget;
    return widget is JsonExampleProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}

class JsonExampleCoder {
  void encode() {
    try {
      final objects = humans.map((e) => e.toJson()).toList();
      final jsonString = jsonEncode(objects);
      print(jsonString);
    } catch (error) {
      print(error);
    }
  }

  void decode() {
    try {
      final json = jsonDecode(jsonString) as List<dynamic>;
      final humans = json
          .map((dynamic e) => Human.fromJson(e as Map<String, dynamic>))
          .toList();
      print(humans);
    } catch (error) {
      print(error);
    }
  }
}
