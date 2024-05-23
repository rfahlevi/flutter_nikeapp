import 'package:flutter_nikeapp/domain/entities/user.dart';

import '../../../domain/entities/result.dart';

abstract interface class AuthRepository {
  Future<Result<User>> login({
    required String email,
    required String password,
  });

  Future<Result<bool>> logout();

  Future<Result<User>> getUser();
}
