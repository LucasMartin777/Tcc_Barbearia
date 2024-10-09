import 'package:barbearia_tcc/src/core/restClient/interceptors/auth_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

final class RestClient extends DioForNative {
  RestClient()
      : super(BaseOptions(
          baseUrl: 'http://192.168.0.105:8080',
          connectTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 60),
        )) {
    interceptors.addAll([
      LogInterceptor(request: true, responseBody: true),
      AuthInterceptor(),
    ]);
  }

  RestClient get auth {
    options.extra['DIO_AUTH_KEY'] = true;
    return this;
  }

  RestClient get unauth {
    options.extra['DIO_AUTH_KEY'] = false;
    return this;
  }
}
