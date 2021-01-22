import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_app/core/data/config.dart';

import 'logging_interceptor.dart';

class NetworkService {
  static const int REQUEST_TIME_OUT = 10 * 1000;

  Dio dio;
  Dio withBearer;

  NetworkService() {
    dio = Dio(_baseOptions);
    dio.interceptors.add(LoggingInterceptor());
  }

  BaseOptions _baseOptions = BaseOptions(
    baseUrl: Config.baseUrl,
    connectTimeout: REQUEST_TIME_OUT,
    receiveTimeout: REQUEST_TIME_OUT,
    responseType: ResponseType.json,
    followRedirects: true,
  );

  Map<String, dynamic> headersRequest() {
    return {
      'Content-Type': 'application/json',
    };
  }

  /// Send Http GET Request
  Future<Response> get({
    String url,
    Map<String, dynamic> parameters,
    Function(int, int) onReceiveProgress,
    ResponseType responseType,
  }) async {
    return await _safeFetch(
      () => dio.get(
        url,
        queryParameters: parameters,
        onReceiveProgress: onReceiveProgress,
        options: Options(
          headers: headersRequest(),
          responseType: responseType,
        ),
      ),
    );
  }

  /// Send Http POST Request
  Future<Response> post(
      {String url,
      dynamic data,
      Function(int, int) onReceiveProgress,
      Function(int, int) onSendProgress,
      ResponseType responseType}) async {
    return await _safeFetch(
      () => dio.post(
        url,
        data: data,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        options: Options(
          responseType: responseType,
          headers: headersRequest(),
        ),
      ),
    );
  }

  /// Send Http PUT Request
  Future<Response> put({String url, Map<String, dynamic> data}) async {
    return await _safeFetch(() =>
        dio.put(url, data: data, options: Options(headers: headersRequest())));
  }

  /// Send Http DELETE Request
  Future<Response> delete(
      {String url, dynamic data, Map<String, dynamic> parameters}) async {
    return await _safeFetch(() => dio.delete(url,
        data: data,
        queryParameters: parameters,
        options: Options(headers: headersRequest())));
  }

  /// Send Http UPLOAD Request
  Future<Response> upload({String url, FormData formData}) async {
    return await _safeFetch(() => dio.post(url,
        data: formData, options: Options(headers: headersRequest())));
  }

  /// Send Http download Request
  Future<Response> download(
      {@required String url,
      @required String savePath,
      @required ProgressCallback onReceiveProgress}) async {
    return await _safeFetch(
      () => dio.download(
        url,
        savePath,
        onReceiveProgress: onReceiveProgress,
        options: Options(headers: headersRequest()),
      ),
    );
  }

  /// Wrap fetch (get/post) request with try-catch
  /// & error handling
  Future<Response> _safeFetch(Future<Response> Function() tryFetch) async {
    try {
      final response = await tryFetch();
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }
}
