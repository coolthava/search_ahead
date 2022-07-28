import 'package:search_ahead/core/common/network/http_response.dart';
import 'package:search_ahead/core/common/network/options.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

abstract class INetworkClient {
  Future<HttpResponse<T>> get<T>(String path,
      {Map<String, dynamic> queryParameters,
      NetworkOptions? options,
      CacheOptions? cacheOptions});

  Future<HttpResponse<T>> getUri<T>(String url, {NetworkOptions? options});

  Future<HttpResponse<T>> post<T>(String path,
      {dynamic data,
      Map<String, dynamic> queryParameters,
      NetworkOptions? options,
      CacheOptions? cacheOptions});

  Future<HttpResponse<T>> put<T>(String path,
      {dynamic data,
      Map<String, dynamic> queryParameters,
      NetworkOptions? options});

  Future<HttpResponse<T>> delete<T>(String path,
      {dynamic data,
      Map<String, dynamic> queryParameters,
      NetworkOptions? options});

  Future<HttpResponse<T>> patch<T>(String path,
      {dynamic data,
      Map<String, dynamic> queryParameters,
      NetworkOptions? options});
}
