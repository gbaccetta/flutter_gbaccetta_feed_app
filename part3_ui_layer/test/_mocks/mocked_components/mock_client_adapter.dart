import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

enum ApiMethod { get, post, put, del }

class MockClientAdapter {
  late final DioAdapter _adapter;
  MockClientAdapter({required Dio dio}) {
    _adapter = DioAdapter(dio: dio);
  }

  OnApiCall onApiCall(ApiMethod method, String endpoint) {
    return OnApiCall(_adapter, endpoint, method);
  }
}

class OnApiCall {
  final DioAdapter adapter;
  final String endpoint;
  final ApiMethod method;
  const OnApiCall(this.adapter, this.endpoint, this.method);

  void thenAnswer(int code, {dynamic response, Duration? delay}) {
    reply() => (server) => server.reply(
          code,
          response ?? {},
          delay: delay ?? const Duration(milliseconds: 100),
        );

    switch (method) {
      case ApiMethod.get:
        adapter.onGet(endpoint, reply());
        break;
      case ApiMethod.post:
        adapter.onPost(endpoint, reply());
        break;
      case ApiMethod.put:
        adapter.onPut(endpoint, reply());
        break;
      case ApiMethod.del:
        adapter.onDelete(endpoint, reply());
        break;
    }
  }
}
