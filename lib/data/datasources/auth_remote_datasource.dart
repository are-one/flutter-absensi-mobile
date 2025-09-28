import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_absensi_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_absensi_app/data/models/response/auth_response_model.dart';
import 'package:flutter_absensi_app/data/models/response/error_response_model.dart';
import 'package:http/http.dart' as http;
import '../../core/constants/variables.dart';

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
    String email,
    String password,
  ) async {
    final url = Uri.parse('${Variables.baseUrl}/api/login');

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      final errorData = ErrorResponseModel.fromJson(response.body);
      return Left('Failed to login: ${errorData.message ?? 'Unknown error'}');
    }
  }

  // Logout
  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDataSource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/logout');

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
    );

    if (response.statusCode == 200) {
      await AuthLocalDataSource().removeAuthData();
      return const Right('Logout successful');
    } else {
      final errorData = ErrorResponseModel.fromJson(response.body);
      return Left('Failed to logout: ${errorData.message ?? 'Unknown error'}');
    }
  }
}
