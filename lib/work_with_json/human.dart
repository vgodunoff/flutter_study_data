import 'package:flutter_study_data/work_with_json/adress.dart';
import 'package:json_annotation/json_annotation.dart';

part 'human.g.dart';

@JsonSerializable()
class Human {
  @JsonKey(name: 'first_name')
  String name;
  String sirname;
  int age;
  List<Adress> adresses;

  Human(
      {required this.name,
      required this.sirname,
      required this.age,
      required this.adresses});

// код с использованием json_serialisible
  factory Human.fromJson(Map<String, dynamic> json) => _$HumanFromJson(json);
  Map<String, dynamic> toJson() => _$HumanToJson(this);

//код вручную

//   factory Human.fromJson(Map<String, dynamic> json) {
//     return Human(
//         name: json['name'] as String,
//         sirname: json['sirname'] as String,
//         age: json['age'] as int,
//         adresses: (json['adresses'] as List<dynamic>)
//             .map((dynamic e) => Adress.fromJson(e as Map<String, dynamic>))
//             .toList());
//   }

//   Map<String, dynamic> toJson() {
//     return <String, dynamic>{
//       'name': name,
//       'sirname': sirname,
//       'age': age,
//       /*
// нельзя просто указать в адресах adresses. потому что в этом массиве лежат объекты, и их
// надо тоже перевести в строки.
// поэтому мы мапим массив и каждый объект переводим в json-строку с помощью нашего метода toJson()
//        */
//       'adresses': adresses.map((e) => e.toJson()).toList()
//     };
//   }
}
