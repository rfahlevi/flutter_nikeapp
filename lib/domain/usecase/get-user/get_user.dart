import 'package:flutter_nikeapp/data/repositories/auth/auth_repository.dart';
import 'package:flutter_nikeapp/domain/entities/result.dart';
import 'package:flutter_nikeapp/domain/entities/user.dart';
import 'package:flutter_nikeapp/domain/usecase/usecase.dart';

class GetUser implements Usecase<Result<User>, void> {
  final AuthRepository _authRepository;

  GetUser({required AuthRepository authRepository}) : _authRepository = authRepository;

  @override
  Future<Result<User>> call(_) async {
    final result = await _authRepository.getUser();

    return switch (result) {
      Success(value: final user) => Result.success(user),
      Failed(:final message) => Result.failed(message),
    };
  }
}
