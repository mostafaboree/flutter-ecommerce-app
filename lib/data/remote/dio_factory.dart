import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_app/data/api_constent.dart';

class DioFactory {
  static final DioFactory _instance = DioFactory._internal();
  late  Dio _dio;

  factory DioFactory() {
    return _instance;
  }

  
DioFactory._internal() {
    _dio = Dio(BaseOptions(baseUrl: ApiConstent.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
    }));

    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    }
  }

  Dio get dio => _dio;

}