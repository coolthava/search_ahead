// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_exception.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiException _$ApiExceptionFromJson(Map<String, dynamic> json) => ApiException(
      responseCode: json['responseCode'] as int,
      responseMessage: json['responseMessage'] as String,
      response: Response.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApiExceptionToJson(ApiException instance) =>
    <String, dynamic>{
      'responseCode': instance.responseCode,
      'responseMessage': instance.responseMessage,
      'response': instance.response,
    };

Response _$ResponseFromJson(Map<String, dynamic> json) => Response(
      errors: (json['errors'] as List<dynamic>)
          .map((e) => Errors.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
      'errors': instance.errors,
    };

Errors _$ErrorsFromJson(Map<String, dynamic> json) => Errors(
      errorCode: json['errorCode'] as String,
      errorTitle: json['errorTitle'] as String,
      errorDescription: json['errorDescription'] as String,
      errorDebugDescription: json['errorDebugDescription'] as String,
    );

Map<String, dynamic> _$ErrorsToJson(Errors instance) => <String, dynamic>{
      'errorCode': instance.errorCode,
      'errorTitle': instance.errorTitle,
      'errorDescription': instance.errorDescription,
      'errorDebugDescription': instance.errorDebugDescription,
    };
