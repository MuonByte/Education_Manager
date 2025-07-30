import 'package:client/features/profile/data/model/delete_account_request.dart';

abstract class DeleteAccountRepository {
  Future<void> deleteAccount(DeleteAccountRequestParameters params);
}
