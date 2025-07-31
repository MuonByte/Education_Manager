import 'package:client/core/network/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalService {
  Future<void> init();
  Future<bool> isAuth();
  Future<void> logout();
  Future<void> saveUserId(String userId);
  Future<String?> getUserId();
  String? getUserIdSync();
}

class AuthLocalServiceImplementation extends AuthLocalService {
  final DioClient dioClient;
  String? _cachedUserId;
  late SharedPreferences _prefs;

  AuthLocalServiceImplementation(this.dioClient);

  @override
  Future<bool> isAuth() async {
    final uri = Uri.parse(dioClient.dio.options.baseUrl);
    final cookies = await dioClient.cookieJar.loadForRequest(uri);

    return cookies.any((cookie) => cookie.name == 'Authorization' || cookie.name == 'login');
  }

  @override
  Future<void> logout() async {
    final uri = Uri.parse(dioClient.dio.options.baseUrl);
    await dioClient.cookieJar.delete(uri);
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
  }

  @override
  Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
  }

  @override
  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

    Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _cachedUserId = _prefs.getString('users_id');
  }

  String? getUserIdSync() => _cachedUserId;
}
