import 'dart:developer';

import 'package:arainii_app_template/models/common_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const int timeout = 30; // in second
List<CommonResponse> logGroup = [];

class ApiService {
  static Dio dioClient = Dio();
  ApiService.init() {
    String baseUrl = dotenv.env['SERVICES_ENDPOINT'] ?? "";
    BaseOptions baseOptions = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: timeout),
      responseType: ResponseType.json,
      // headers: {},
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
          final commonResponse = CommonResponse(
            path: response.requestOptions.path,
            method: response.requestOptions.method,
            statusCode: response.statusCode,
            response: response.data,
            responseTime: DateTime.now().toIso8601String(),
            body: response.requestOptions.data,
          );

          logGroup.add(commonResponse);
          handler.next(response);
        }
      },
      onError: (DioError err, ErrorInterceptorHandler handler) {
        final commonResponse = CommonResponse(
          path: err.requestOptions.path,
          method: err.requestOptions.method,
          statusCode: err.response?.statusCode,
          response: err.response?.data,
          responseTime: DateTime.now().toIso8601String(),
          body: err.response?.requestOptions.data,
        );
        logGroup.add(commonResponse);
        handler.reject(err);
      },
    ));
    dioClient = dio;
  }

  static Future<dynamic> getJsonPlaceHolder() async {
    final servicesRes = await dioClient.get('/todos/1');
    if (servicesRes.statusCode == 200) {
      return servicesRes.data;
    } else {
      throw Exception("ERROR");
    }
  }

  static Future<dynamic> getMockData(int code) async {
    try {
      final servicesRes = await dioClient.get('/get_mock?status=$code');
      if (servicesRes.statusCode == 200) {
        log(servicesRes.data.toString());
      } else {
        throw Exception('Exception : Error Occured');
      }
    } catch (err) {
      return err;
    }
  }
}
