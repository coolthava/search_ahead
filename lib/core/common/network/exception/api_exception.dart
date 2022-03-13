import 'package:json_annotation/json_annotation.dart';

part 'api_exception.g.dart';

@JsonSerializable()
class ApiException {
  final int responseCode;
  final String responseMessage;
  final Response response;

  ApiException(
      {required this.responseCode,
      required this.responseMessage,
      required this.response});

  factory ApiException.fromJson(Map<String, dynamic> json) =>
      _$ApiExceptionFromJson(json);
  Map<String, dynamic> toJson() => _$ApiExceptionToJson(this);
}

@JsonSerializable()
class Response {
  final List<Errors> errors;

  Response({required this.errors});

  factory Response.fromJson(Map<String, dynamic> json) =>
      _$ResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseToJson(this);
}

@JsonSerializable()
class Errors {
  final String errorCode;
  final String errorTitle;
  final String errorDescription;
  final String errorDebugDescription;

  Errors(
      {required this.errorCode,
      required this.errorTitle,
      required this.errorDescription,
      required this.errorDebugDescription});

  factory Errors.fromJson(Map<String, dynamic> json) => _$ErrorsFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorsToJson(this);
}
