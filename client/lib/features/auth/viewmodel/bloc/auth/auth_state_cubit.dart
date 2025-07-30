import 'package:client/core/usecase/usecase.dart';
import 'package:client/features/auth/data/model/login_request.dart';
import 'package:client/features/auth/data/model/register_request.dart';
import 'package:client/features/auth/domain/usecases/get_user.dart';
import 'package:client/features/auth/domain/usecases/login_usecase.dart';
import 'package:client/features/auth/domain/usecases/signup_usecase.dart';
import 'package:client/features/auth/viewmodel/bloc/auth/auth_state.dart';
import 'package:client/features/auth/domain/usecases/is_auth_usecase.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AuthStateCubit extends Cubit<AuthState> {
  final GetUserUsecase getCurrentUserUsecase;
  final IsAuthUsecase isAuthUsecase;

  AuthStateCubit(this.getCurrentUserUsecase, this.isAuthUsecase) : super(AppInitialState());

  Future<void> started() async {
    final isAuth = await isAuthUsecase.call();
    if (isAuth) {
      final result = await getCurrentUserUsecase.call(param: NoParams());
      result.fold(
        (error) => emit(Unauthenticated()),
        (user) => emit(Authenticated(user)),
      );
    } else {
      emit(Unauthenticated());
    }
  }
  Future<void> login(LoginRequestParameters params, LoginUsecase loginUsecase) async {
    final result = await loginUsecase.call(param: params);

    result.fold(
      (failure) => emit(Unauthenticated()),
      (responseMessage) {
        if (responseMessage.contains("otp")) {
          emit(NeedsVerification(responseMessage));
        } else {
          emit(Unauthenticated());
        }
      },
    );
  }
  Future<void> signup(SignupRequestParameters params, SignupUsecases usecase) async {
  final result = await usecase.call(param: params);

  result.fold(
    (failure) => emit(Unauthenticated()),
    (response) {
      if (response.statusCode == 201) {
        emit(NeedsVerification("verify your email"));
      } else {
        emit(Unauthenticated());
      }
    },
  );
}
}