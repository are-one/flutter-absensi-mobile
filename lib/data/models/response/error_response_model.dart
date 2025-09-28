import 'dart:convert';

class ErrorResponseModel {
  final String? message;

  ErrorResponseModel({this.message});

  factory ErrorResponseModel.fromJson(String str) =>
      ErrorResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ErrorResponseModel.fromMap(Map<String, dynamic> json) =>
      ErrorResponseModel(message: json["message"]);

  Map<String, dynamic> toMap() => {"message": message};
}
