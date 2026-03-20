class ErrorResponse {
  final String? cod;
  final String? message;

  ErrorResponse({this.cod, this.message});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        cod: json['cod']?.toString(),
        message: json['message']?.toString(),
      );

  Map<String, dynamic> toJson() {
    return {
      'cod': cod,
      'message': message,
    };
  }
}
