// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_exception.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiException _$ApiExceptionFromJson(Map<String, dynamic> json) => ApiException(
      responseCode: json['responseCode'] as int,
      responseMessage: json['responseMessage'] as String,
    );

Map<String, dynamic> _$ApiExceptionToJson(ApiException instance) =>
    <String, dynamic>{
      'responseCode': instance.responseCode,
      'responseMessage': instance.responseMessage,
    };
