import 'dart:developer';

import 'package:arainii_app_template/models/common_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const int timeout = 30; // in second
List<CommonResponse> logGroup = [
  CommonResponse(
      path: "api/v1/orch-get_personal-receipt-information",
      method: "GET",
      statusCode: 200,
      responseTime: DateTime.now().toIso8601String(),
      response: {
        "code": 1000,
        "data": [],
      }),
  CommonResponse(
      path: "api/v1/orch-create-customer-prize-redeem-channel",
      method: "POST",
      statusCode: 400,
      responseTime: DateTime.now().toIso8601String(),
      response: null),
  CommonResponse(
      path: "api/v1/orch-create-customer-prize-redeem-channel",
      method: "POST",
      body: {
        "name": "test",
        "desc": "lorem ipsum ",
      },
      statusCode: 200,
      responseTime: DateTime.now().toIso8601String(),
      response: {"code": 1000, "data": "create success"}),
  CommonResponse(
      path: "api/v1/delete_data",
      method: "DELETE",
      statusCode: 200,
      responseTime: DateTime.now().toIso8601String(),
      response: {
        "code": 1000,
        "data": "Delete Complete",
      }),
  CommonResponse(
      path: "api/v1/create_bill",
      method: "POST",
      statusCode: 404,
      responseTime: DateTime.now().toIso8601String(),
      response: null),
  CommonResponse(
      path: "api/v1/update_bill",
      method: "PUT",
      statusCode: 500,
      responseTime: DateTime.now().toIso8601String(),
      response: null),
  CommonResponse(
      path: "api/v1/get_cost",
      method: "GET",
      statusCode: 200,
      responseTime: DateTime.now().toIso8601String(),
      response: {
        "code": 5000,
        "error_data": {
          "err_title": "Cannot Calculate",
          "err_desc": "Error",
        }
      }),
];

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
}
