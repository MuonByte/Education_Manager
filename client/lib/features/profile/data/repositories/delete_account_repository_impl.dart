import 'package:client/core/constants/api_urls.dart';
import 'package:client/core/network/dio_client.dart';
import 'package:client/features/profile/data/model/delete_account_request.dart';
import 'package:client/features/profile/domain/repositories/delete_account_repository.dart';

class DeleteAccountRepositoryImpl implements DeleteAccountRepository {
  final DioClient networkService;

  DeleteAccountRepositoryImpl(this.networkService);

  @override
  Future<void> deleteAccount(DeleteAccountRequestParameters params) async {
    try {
      await networkService.delete(
        ApiUrls.userProfileURL,
        data: params.toMap(),
      );
    } catch (e) {
      rethrow;
    }
  }
}
