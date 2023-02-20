import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static Dio dioClient = Dio();
  ApiService.init() {
    String baseUrl = dotenv.env['SERVICES_ENDPOINT'] ?? "";

    BaseOptions baseOptions = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(milliseconds: 10000),
    );
    final Dio dio = Dio(baseOptions);

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        log("${options.baseUrl}${options.path}");
        handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        if (response.statusCode != 200) {
          handler.reject(DioError(requestOptions: response.requestOptions));
        } else {
          handler.next(response);
        }
      },
      onError: (DioError err, ErrorInterceptorHandler handler) {
        handler.reject(err);
      },
    ));
    dioClient = dio;
  }

  static Future<dynamic> getJsonPlaceHolder() async {
    try {
      final servicesRes = await dioClient.get('/todos/1');
      if (servicesRes.statusCode == 200) {
        return servicesRes.data;
      } else {
        throw Exception("");
      }
    } catch (err) {
      rethrow;
    }
  }
}
