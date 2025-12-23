import 'package:dio/dio.dart';
import 'package:hm_shop/constants/index.dart';

class Request {
  static final Request _instance = Request._internal();
  factory Request() => _instance;

  late final Dio _dio;

  Request._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: GlobalConstants.BASE_URL,
        connectTimeout: Duration(seconds: GlobalConstants.TIME_OUT),
        receiveTimeout: Duration(seconds: GlobalConstants.TIME_OUT),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // 请求拦截器
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (error, handler) {
          // return handler.next(error);
          handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              message: error.response?.data['msg'] ?? '请求失败',
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async {
    try {
      Response<dynamic> response = await task;
      final data = response.data as Map<String, dynamic>;
      if (data['code'] == GlobalConstants.SUCCESS_CODE) {
        return data['result'];
      }
      throw Exception(data['msg'] ?? '请求失败');
    } catch (e) {
      rethrow;
    }
  }

  // 静态方法 - 避免重复调用工厂构造函数
  static Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _instance._handleResponse(
      _instance._dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }

  static Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    return _instance._handleResponse(
      _instance._dio.post(
        path,
        data: data,
        queryParameters: params,
        options: options,
      ),
    );
  }

  static Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    return _instance._handleResponse(
      _instance._dio.put(
        path,
        data: data,
        queryParameters: params,
        options: options,
      ),
    );
  }

  static Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    return _instance._handleResponse(
      _instance._dio.delete(
        path,
        data: data,
        queryParameters: params,
        options: options,
      ),
    );
  }
}
