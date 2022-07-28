import 'package:equatable/equatable.dart';
import 'package:search_ahead/core/common/network/exception/api_exception.dart';

class BaseException extends Equatable implements Exception {
  @override
  List<Object?> get props => [];
}

class NetworkException extends BaseException {
  @override
  String toString() {
    return 'Check your network';
  }
}

class HttpException extends BaseException {
  final dynamic response;
  final String? errorMsg;
  final int? errorCode;
  final ApiException? apiException;

  HttpException.apiException(
      {required this.apiException,
      this.response,
      this.errorCode,
      this.errorMsg});

  HttpException.serverException(this.errorMsg, this.response,
      {this.errorCode, this.apiException});

  HttpException(
      {this.response, this.errorCode, this.errorMsg, this.apiException});

  @override
  String toString() {
    return errorMsg ?? response.toString();
  }

  @override
  List<Object?> get props => [response, errorMsg, errorCode, apiException];
}
