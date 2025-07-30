import 'package:client/core/usecase/usecase.dart';
import 'package:client/features/profile/data/model/delete_account_request.dart';
import 'package:client/features/profile/domain/repositories/delete_account_repository.dart';

class DeleteAccountUsecase implements Usecase<void, DeleteAccountRequestParameters> {
  final DeleteAccountRepository repository;

  DeleteAccountUsecase(this.repository);

  @override
  Future<void> call({required DeleteAccountRequestParameters param}) async {
    return await repository.deleteAccount(param);
  }
}
