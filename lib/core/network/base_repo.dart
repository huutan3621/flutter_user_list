import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_user_list/core/utils/app_constants.dart';

abstract class AppBaseRepo {
  @protected
  _DioHelper get _helper => _DioHelper.getInstance(
        whiteAuthList: whiteAuthList,
        onRequest: onRequest,
        onResponse: onResponse,
        onError: onError,
        accessToken: accessToken,
      );

  @protected
  Dio get dio => _helper.dio;

  Future<Response> get(path, [data, Map<String, dynamic>? queries]) async {
    return _helper.get(
      path,
      data: data,
      queryParameters: queries,
    );
  }

  Future<Response> post(path, body, [Map<String, dynamic>? queries]) async {
    return _helper.post(
      path,
      body,
      queryParameters: queries,
    );
  }

  @protected
  List<String> get whiteAuthList;

  @protected
  Future<String> get accessToken;

  @protected
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    return handler.next(options);
  }

  @protected
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @protected
  void onError(DioException e, ErrorInterceptorHandler handler) {
    return handler.next(e);
  }
}

class _DioHelper {
  static const int _connectTimeout = 30;
  static const int _receiveTimeout = 30;
  static const int _sendTimeout = 30;

  final _dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: _connectTimeout),
      receiveTimeout: const Duration(seconds: _receiveTimeout),
      sendTimeout: const Duration(seconds: _sendTimeout),
    ),
  );
  final List<String> whiteAuthList;
  final void Function(RequestOptions, RequestInterceptorHandler)? onRequest;
  final void Function(Response<dynamic>, ResponseInterceptorHandler)?
      onResponse;
  final void Function(DioException, ErrorInterceptorHandler)? onError;
  final Future<String> accessToken;
  var options = Options(
      contentType: Headers.jsonContentType, responseType: ResponseType.json);

  _DioHelper._({
    required this.whiteAuthList,
    required this.accessToken,
    this.onRequest,
    this.onResponse,
    this.onError,
  }) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        if (options.data is FormData) {
          options.contentType = Headers.multipartFormDataContentType;
        }

        if (onRequest != null) {
          return onRequest!(options, handler);
        }

        return handler.next(options);
      },
      onResponse: (response, handler) {
        if (onResponse != null) {
          return onResponse!(response, handler);
        }

        return handler.next(response);
      },
      onError: (e, handler) async {
        if (e.response != null) {}

        if (onError != null) {
          return onError!(e, handler);
        }

        return handler.next(e);
      },
    ));
  }

  factory _DioHelper.getInstance({
    required List<String> whiteAuthList,
    void Function(RequestOptions, RequestInterceptorHandler)? onRequest,
    void Function(Response<dynamic>, ResponseInterceptorHandler)? onResponse,
    void Function(DioException, ErrorInterceptorHandler)? onError,
    required Future<String> accessToken,
  }) =>
      _DioHelper._(
        whiteAuthList: whiteAuthList,
        onRequest: onRequest,
        onResponse: onResponse,
        onError: onError,
        accessToken: accessToken,
      );

  Dio get dio => _dio;

  Future<Response> get(
    path, {
    data,
    Options? options,
    Map<String, dynamic>? queryParameters,
  }) async {
    var res = await _dio.get(
      path,
      options: options ?? this.options,
      data: data,
      queryParameters: queryParameters,
    );
    return res;
  }

  Future<Response> post(
    path,
    body, {
    Options? options,
    Map<String, dynamic>? queryParameters,
  }) async {
    var res = await _dio.post(
      path,
      data: body,
      options: options ?? this.options,
      queryParameters: queryParameters,
    );
    return res;
  }
}
