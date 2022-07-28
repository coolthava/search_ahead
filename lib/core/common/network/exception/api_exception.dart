import 'package:json_annotation/json_annotation.dart';

part 'api_exception.g.dart';

@JsonSerializable()
class ApiException {
  final int responseCode;
  final String responseMessage;

  ApiException({
    required this.responseCode,
    required this.responseMessage,
  });

  factory ApiException.fromJson(Map<String, dynamic> json) =>
      _$ApiExceptionFromJson(json);
  Map<String, dynamic> toJson() => _$ApiExceptionToJson(this);
}
