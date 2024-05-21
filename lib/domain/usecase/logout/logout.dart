import 'package:flutter_nikeapp/data/repositories/auth/auth_repository.dart';
import 'package:flutter_nikeapp/domain/usecase/usecase.dart';

import '../../entities/result.dart';

class Logout implements Usecase<Result<bool>, void> {
  final AuthRepository _authRepository;

  Logout({required AuthRepository authRepository}) : _authRepository = authRepository;

  @override
  Future<Result<bool>> call(_) async {
    var result = await _authRepository.logout();

    return switch (result) {
      Success(value: final _) => const Result.success(true),
      Failed(:final message) => Result.failed(message),
    };
  }
}
