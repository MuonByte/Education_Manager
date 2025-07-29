import 'package:client/core/usecase/usecase.dart';
import 'package:client/features/auth/domain/usecases/get_user.dart';
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
}