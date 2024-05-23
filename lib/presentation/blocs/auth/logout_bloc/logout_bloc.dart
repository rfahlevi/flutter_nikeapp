import 'package:bloc/bloc.dart';
import 'package:flutter_nikeapp/domain/entities/result.dart';
import 'package:flutter_nikeapp/domain/usecase/logout/logout.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_nikeapp/data/repositories/auth/auth_repository.dart';

part 'logout_bloc.freezed.dart';
part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthRepository _authRepository;
  LogoutBloc(
    this._authRepository,
  ) : super(const _Initial()) {
    on<_DoLogout>((event, emit) async {
      emit(const _Loading());

      Logout logout = Logout(authRepository: _authRepository);

      final result = await logout(null);

      switch (result) {
        case Success(value: final hasLogout):
          emit(_Success(hasLogout: hasLogout));
          break;
        case Failed(:final message):
          emit(_Failed(message: message));
          break;
      }
    });
  }
}
