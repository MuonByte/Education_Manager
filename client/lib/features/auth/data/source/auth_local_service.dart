import 'package:client/core/network/dio_client.dart';

abstract class AuthLocalService {
  Future<bool> isAuth();
  Future<void> logout();
}

class AuthLocalServiceImplementation extends AuthLocalService {
  final DioClient dioClient;

  AuthLocalServiceImplementation(this.dioClient);

  @override
  Future<bool> isAuth() async {
    final uri = Uri.parse(dioClient.dio.options.baseUrl);
    final cookies = await dioClient.cookieJar.loadForRequest(uri);

    return cookies.any((cookie) => cookie.name == 'session' || cookie.name == 'login');
  }

  @override
  Future<void> logout() async {
    final uri = Uri.parse(dioClient.dio.options.baseUrl);
    await dioClient.cookieJar.delete(uri);
  }
}
