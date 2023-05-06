import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../config.dart';

Dio dioClient() {
  Dio dio = Dio();
  Logger logger = Logger();

  dio.options.baseUrl = Config().apiHost;

  dio.interceptors.add(
    InterceptorsWrapper(
      onError: (DioError e, ErrorInterceptorHandler handler) {
        logger.e(e);
        return handler.next(e);
      },
    ),
  );

  return dio;
}
