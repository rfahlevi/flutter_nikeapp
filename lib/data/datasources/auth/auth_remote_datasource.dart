import 'package:flutter_nikeapp/data/datasources/auth/auth_local_datasource.dart';
import 'package:flutter_nikeapp/data/repositories/auth/auth_repository.dart';
import 'package:flutter_nikeapp/domain/entities/result.dart';
import 'package:flutter_nikeapp/domain/entities/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter_nikeapp/helper/const.dart';

class AuthRemoteDatasource implements AuthRepository {
  final Dio _dio;

  AuthRemoteDatasource({Dio? dio}) : _dio = dio ?? Dio();

  String baseUrl = NikeConst.baseUrl;

  @override
  Future<Result<User>> login({
    required String email,
    required String password,
  }) async {
    try {
      String apiUrl = '$baseUrl/login';

      FormData credentials = FormData.fromMap({
        "email": email,
        "password": password,
      });

      final response = await _dio.post(
        apiUrl,
        data: credentials,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      final result = response.data;

      if (result['status'] == true) {
        await AuthLocalDatasource().saveAuthData(User.fromJson(result['data']));
        await AuthLocalDatasource().saveToken(result['token']);
        return Result.success(User.fromJson(result['data']));
      } else {
        return Result.failed(result['message']);
      }
    } on DioException catch (e) {
      return Result.failed(e.response?.data ?? "Something went wrong");
    }
  }

  @override
  Future<Result<bool>> logout() async {
    try {
      String apiUrl = '$baseUrl/logout';
      String? token = await AuthLocalDatasource().getToken();

      final response = await _dio.post(
        apiUrl,
        options: Options(
          headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer $token'},
        ),
      );

      final result = response.data;

      if (result['status'] == true) {
        await AuthLocalDatasource().removeAuthData();
        await AuthLocalDatasource().removeToken();
        return const Result.success(true);
      } else {
        return Result.failed(result['message']);
      }
    } on DioException catch (e) {
      return Result.failed(e.response?.statusMessage ?? "Something went wrong");
    }
  }
}
