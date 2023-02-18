import 'package:flutter_study_data/work_with_json/adress.dart';
import 'package:flutter_study_data/work_with_json/human.dart';

final humans = [
  Human(name: 'Вася', sirname: 'Пупкин', age: 28, adresses: [
    Adress(city: 'Moskva', street: 'Kashirskaya', house: '15', flat: 14),
    Adress(city: 'SPb', street: 'Kashirskaya', house: '7', flat: 8)
  ]),
  Human(name: 'Сергей', sirname: 'Иванов', age: 38, adresses: [
    Adress(city: 'Кишинев', street: 'Ломоносов', house: '5', flat: 4),
    Adress(city: 'ЕКБ', street: 'Луночарского', house: '8а', flat: 98)
  ])
];

const String jsonString = '''
[
  {
    "id": 1,
    "first_name": "Leanne Graham",
    "sirname": "Bret",
    "age": 25,
    "adresses": [
        {
        "street": "Victor Plains",
        "flat": 1,
        "house": "6",
        "city": "Костанай"
      },
      {
        "street": "Керамическая",
        "flat": 2,
        "house": "4",
        "city": "Москва"
      }
    ]
  },
  {
    "id": 2,
    "first_name": "Ervin Howell",
    "sirname": "Antonette",
    "age": 21,
    "email": "Shanna@melissa.tv",
    "adresses": [
        {
        "street": "Victor Plains",
        "flat": 1,
        "house": "5",
        "city": "Wisokyburgh"
      },
      {
        "street": "Керамическая",
        "flat": 1,
        "house": "3",
        "city": "Москва"
      }
    ]
  }
]

''';
