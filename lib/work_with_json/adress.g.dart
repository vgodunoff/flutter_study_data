// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Adress _$AdressFromJson(Map<String, dynamic> json) => Adress(
      city: json['city'] as String,
      street: json['street'] as String,
      house: json['house'] as String,
      flat: json['flat'] as int,
    );

Map<String, dynamic> _$AdressToJson(Adress instance) => <String, dynamic>{
      'city': instance.city,
      'street': instance.street,
      'house': instance.house,
      'flat': instance.flat,
    };
