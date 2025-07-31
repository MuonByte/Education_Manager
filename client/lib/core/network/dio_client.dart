import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';

import 'interceptors.dart';

class DioClient {
  final Dio dio;
  final PersistCookieJar cookieJar;
  final String baseUrl;

  DioClient._({
    required this.dio,
    required this.cookieJar,
    required this.baseUrl,
  });

  static Future<DioClient> create({
    String baseUrl = 'http://192.168.1.15:3000',
  }) async {

    final appDocDir  = await getApplicationDocumentsDirectory();
    final cookiePath = '${appDocDir.path}/.cookies/';
    final cj         = PersistCookieJar(storage: FileStorage(cookiePath));

    final d = Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      responseType: ResponseType.json,
      sendTimeout: const Duration(seconds: 40),
      receiveTimeout: const Duration(seconds: 40),
      validateStatus: (status) => status != null && status < 500,
    ));

    d.interceptors.addAll([
      LoggerInterceptor(),
      CookieManager(cj),
      _AuthInterceptor(cj, baseUrl),
    ]);

    return DioClient._(
      dio: d,
      cookieJar: cj,
      baseUrl: baseUrl,
    );
  }

  /* Future<void> _initCookieJar() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final cookiePath = '${appDocDir.path}/.cookies/';
    cookieJar = PersistCookieJar(storage: FileStorage(cookiePath));

    dio.interceptors
      .addAll([
        LoggerInterceptor(),
        CookieManager(cookieJar),
        _AuthInterceptor(cookieJar, baseUrl),
      ]);
  } */

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}

class _AuthInterceptor extends Interceptor {
  final PersistCookieJar cookieJar;
  final String baseUrl;

  _AuthInterceptor(this.cookieJar, this.baseUrl);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.uri.toString().startsWith(baseUrl)) {
      final cookies = await cookieJar.loadForRequest(Uri.parse(baseUrl));

      final authCookie = cookies.firstWhere(
        (c) => c.name == 'Authorization' && c.value.isNotEmpty,
        orElse: () => Cookie('Authorization', ''),
      );

      options.headers['Authorization'] = 'Bearer ${authCookie.value}';

    }
    super.onRequest(options, handler);
  }
}