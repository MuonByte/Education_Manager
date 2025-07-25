import 'package:client/features/auth/domain/usecases/get_user.dart';
import 'package:client/features/profile/viewmodel/bloc/user_display_state.dart';
import 'package:client/services/service_locator.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class UserDisplayCubit extends Cubit<UserDisplayState>{

  UserDisplayCubit() : super(UserLoading());

  Future<void> displayUser() async {
    var result = await sl<GetUserUsecase>().call();
    result.fold(
      (error){
        emit(LoadUserFailure(errorMessage: error));
      },
      (data){
        emit(UserLoaded(userEntity: data));
      }
    );
  }
}