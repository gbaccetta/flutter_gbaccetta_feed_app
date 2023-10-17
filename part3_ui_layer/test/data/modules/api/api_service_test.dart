import 'package:flutter_gbaccetta_feed_app/data/modules/api/api_service.dart';
import 'package:flutter_gbaccetta_feed_app/data/modules/api/endpoints.dart';
import 'package:flutter_gbaccetta_feed_app/domain/failures/api_error.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../_mocks/mocked_components/mock_client_adapter.dart';
import '../../../_mocks/mocked_data/endpoint/medium_rss_feed_mocked.dart';

void main() {
  ApiService? apiService;
  MockClientAdapter? mockClientAdapter;

  setUp(() {
    apiService = ApiService();
    mockClientAdapter = MockClientAdapter(dio: apiService!.dio);
  });

  group('getMediumRssFeed -', () {
    test('Successfully get articles from RSS fields', () async {
      final data = MediumRssFeedMocked().string_200;

      mockClientAdapter!
          .onApiCall(ApiMethod.get, Endpoints.mediumRssFeed)
          .thenAnswer(200, response: data);

      final result = await apiService!.getMediumRssFeed();
      expect(result.data, data);
      expect(result.statusCode, 200);
    });

    test('Fail to get articles from RSS fields', () async {
      ApiError? error;

      mockClientAdapter!
          .onApiCall(ApiMethod.get, Endpoints.mediumRssFeed)
          .thenAnswer(404);

      try {
        await apiService!.getMediumRssFeed();
      } on ApiError catch (e) {
        error = e;
      }
      expect(error, isNotNull);
    });
  });
}
