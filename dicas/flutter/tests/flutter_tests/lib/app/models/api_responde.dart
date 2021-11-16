class ApiResponse<T> {
  int? statusCode;
  T? data;
  String? errorMessage;

  ApiResponse({
    required this.statusCode,
    this.data,
    this.errorMessage,
  });
}
