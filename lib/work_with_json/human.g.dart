// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'human.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Human _$HumanFromJson(Map<String, dynamic> json) => Human(
      name: json['first_name'] as String,
      sirname: json['sirname'] as String,
      age: json['age'] as int,
      adresses: (json['adresses'] as List<dynamic>)
          .map((e) => Adress.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HumanToJson(Human instance) => <String, dynamic>{
      'first_name': instance.name,
      'sirname': instance.sirname,
      'age': instance.age,
      'adresses': instance.adresses,
    };
