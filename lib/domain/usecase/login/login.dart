import 'package:flutter_nikeapp/data/repositories/auth/auth_repository.dart';
import 'package:flutter_nikeapp/domain/entities/result.dart';
import 'package:flutter_nikeapp/domain/entities/user.dart';
import 'package:flutter_nikeapp/domain/usecase/login/login_params.dart';
import 'package:flutter_nikeapp/domain/usecase/usecase.dart';

class Login implements Usecase<Result<User>, LoginParams> {
  final AuthRepository _authRepository;

  Login({required AuthRepository authRepository}) : _authRepository = authRepository;

  @override
  Future<Result<User>> call(LoginParams params) async {
    var result = await _authRepository.login(
      email: params.email,
      password: params.password,
    );

    return switch (result) {
      Success(value: final user) => Result.success(user),
      Failed(:final message) => Result.failed(message),
    };
  }
}
