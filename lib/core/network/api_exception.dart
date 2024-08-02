import 'dart:io';

import 'package:dio/dio.dart';

class ApiException {
  List<String> getExceoptionMessage(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.cancel:
        return ["Bad Response Error", 'Request to API server was cancelled'];

      case DioExceptionType.connectionTimeout:
        return ["Connection Time Out", 'Connection timeout with API server'];

      case DioExceptionType.receiveTimeout:
        return [
          "Receive Time Out",
          'Receive timeout in connection with API server'
        ];

      case DioExceptionType.sendTimeout:
        return ["Send Time Out", 'Send timeout in connection with API server'];

      case DioExceptionType.connectionError:
        if (dioException.error.runtimeType == SocketException) {
          return ["Connection Error", 'Please check your internet connection'];
        } else {
          return ["Error", 'Unexpected error occurred'];
        }

      case DioExceptionType.badCertificate:
        return ["Bad Certificate", 'Bad Certificate'];

      case DioExceptionType.badResponse:
        return ["Bad Response", 'Bad Response'];

      case DioExceptionType.unknown:
        return ["Unknown", 'Unexpected Error Occurred'];
    }
  }
}
