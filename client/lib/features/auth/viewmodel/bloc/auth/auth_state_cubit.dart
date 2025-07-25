import 'package:client/features/auth/viewmodel/bloc/auth/auth_state.dart';
import 'package:client/features/auth/domain/usecases/is_auth_usecase.dart';
import 'package:client/services/service_locator.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AuthStateCubit extends Cubit<AuthState> {

  AuthStateCubit() : super(AppInitialState());


  Future<void> started() async {
    var isAuth = await sl<IsAuthUsecase>().call();
    if(isAuth) {
      emit(Authenticated());
    }
    else {
      emit(Unauthenticated());
    }
  }
}