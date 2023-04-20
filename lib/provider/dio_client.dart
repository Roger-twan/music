import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

Dio dioClient() {
  Dio dio = Dio();
  Logger logger = Logger();

  dio.options.baseUrl = 'https://music.twan.life';

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
