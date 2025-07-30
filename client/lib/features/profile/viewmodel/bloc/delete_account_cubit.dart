import 'package:client/common/bloc/button/button_state.dart';
import 'package:client/core/usecase/usecase.dart';
import 'package:client/features/profile/data/model/delete_account_request.dart';
import 'package:client/features/profile/domain/usecases/delete_account_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteAccountCubit extends Cubit<ButtonState> {
  DeleteAccountCubit() : super(ButtonInitialState());

  Future<void> deleteAccount(DeleteAccountUsecase usecase, DeleteAccountRequestParameters params) async {
    try {
      emit(ButtonLoadingState());
      await usecase.call(param: params);
      emit(ButtonSuccessState());
    } catch (e) {
      emit(ButtonFailureState(errorMessage: e.toString()));
    }
  }
}
