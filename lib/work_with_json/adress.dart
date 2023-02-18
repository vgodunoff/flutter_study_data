import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'adress.g.dart';

@JsonSerializable()
class Adress {
  final String city;
  final String street;
  final String house;
  final int flat;

  Adress(
      {required this.city,
      required this.street,
      required this.house,
      required this.flat});

  //_$AdressFromJson(json) и _$AdressToJson(this) сгенерированы автоматически
  //остается только вручную добавить их к нашему конструктору Adress.fromJson
  //и методу toJson() =>
  factory Adress.fromJson(Map<String, dynamic> json) => _$AdressFromJson(json);
  Map<String, dynamic> toJson() => _$AdressToJson(this);

  //Код ниже составлен вручную

  // factory Adress.fromJson(Map<String, dynamic> json) {
  //   return Adress(
  //       city: json['city'] as String,
  //       street: json['street'] as String,
  //       house: json['house'] as String,
  //       flat: json['flat'] as int);
  // }

  // Map<String, dynamic> toJson() {
  //   return <String, dynamic>{
  //     'city': city,
  //     'street': street,
  //     'house': house,
  //     'flat': flat
  //   };
  // }
}
