class CommonResponse {
  final String? path;
  final String? method;
  final int? statusCode;
  final Map<String, dynamic>? body;
  final Map<String, dynamic>? response;
  final dynamic responseTime;

  CommonResponse({
    this.path,
    this.method,
    this.statusCode,
    this.body,
    this.response,
    this.responseTime,
  });
}
